require "faraday"
require "faraday_middleware"
require "recursive-open-struct"
require "digitalocean/version"
require "digitalocean/droplet"
require "digitalocean/image"
require "digitalocean/size"
require "digitalocean/record"

module Digitalocean
  extend self

  CLIENT_ID_GSUB  = "client_id=[your_client_id]"
  API_KEY_GSUB    = "api_key=[your_api_key]"
  DEFINITIONS     = {
    "Domain" => {
      "all"       => "https://api.digitalocean.com/domains?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"      => "https://api.digitalocean.com/domains/[domain_id]?client_id=[your_client_id]&api_key=[your_api_key]",
      "create"    => "https://api.digitalocean.com/domains/new?client_id=[your_client_id]&api_key=[your_api_key]&name=[domain]&ip_address=[ip_address]", 
      "destroy"   => "https://api.digitalocean.com/domains/[domain_id]/destroy?client_id=[your_client_id]&api_key=[your_api_key]" 
    },
    "Region" => {
      "all"       => "https://api.digitalocean.com/regions/?client_id=[your_client_id]&api_key=[your_api_key]"
    },
    "SshKey" => {
      "all"       => "https://api.digitalocean.com/ssh_keys/?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"      => "https://api.digitalocean.com/ssh_keys/[ssh_key_id]/?client_id=[your_client_id]&api_key=[your_api_key]",
      "create"    => "https://api.digitalocean.com/ssh_keys/new/?name=[ssh_key_name]&ssh_pub_key=[ssh_public_key]&client_id=[your_client_id]&api_key=[your_api_key]"
    }
  }

  DEFINITIONS.each do |resource|
    resource_name = resource[0]

    resource_class = Class.new(Object) do
      singleton = class << self; self end # http://stackoverflow.com/questions/3026943/define-method-for-instance-of-class

      DEFINITIONS[resource_name].each do |method_name, url|
        parts         = url.split("?")
        pre_query     = parts[0]
        post_query    = parts[1]

        singleton.send :define_method, "_#{method_name}" do |*args|
          pre_query   = Digitalocean.process_standard_args_from_part(pre_query, args)
          #post_query  = Digitalocean.inject_client_id_and_api_key(post_query)
          post_query  = Digitalocean.process_hash_args_from_part(post_query, args)

          [pre_query, post_query].join("?")
        end

        singleton.send :define_method, method_name do |*args|
          request_and_respond "_#{method_name}", *args
        end
      end
    end

    Digitalocean.const_set(resource_name, resource_class) 
  end

  def request=(request)
    @request = request
  end

  def request
    @request
  end

  def client_id=(client_id)
    @client_id = client_id
    setup_request!

    @client_id
  end

  def client_id
    return @client_id if @client_id
    "client_id_required"
  end

  def api_key=(api_key)
    @api_key = api_key
    setup_request!

    @api_key
  end

  def api_key
    return @api_key if @api_key
    "api_key_required"
  end

  def api_endpoint
    "https://api.digitalocean.com"
  end

  def credential_attrs
    {:client_id => Digitalocean.client_id, :api_key => Digitalocean.api_key}
  end

  def request_and_respond(url)
    resp = Digitalocean.request.get url
    RecursiveOpenStruct.new(resp.body, :recurse_over_arrays => true)
  end

  def process_standard_args_from_part(part, args)
    parts = part.split(/\[|\]/)

    if parts.length > 1
      parts.each_with_index do |v, i|
        is_every_other = (i%2 == 1)
        parts[i] = args.shift if is_every_other
      end
    end

    parts.join("")
  end

  def process_client_id_and_api_key(parts)
    # Begin by taking care of the client_id and api_key
    client_id_index = parts.index "client_id="
    client_id_index = parts.index "&client_id=" if !client_id_index
    parts[client_id_index+1] = client_id
    api_key_index = parts.index "api_key="
    api_key_index = parts.index "&api_key=" if !api_key_index
    parts[api_key_index+1] = api_key

    parts
  end

  def process_hash_args_from_part(part, args)
    parts = part.split(/\[|\]/)
    parts = process_client_id_and_api_key(parts)

    if parts.length > 1

      hash = args[-1]

      if hash.is_a?(Hash)
        hash.each do |key, value|
          query_setter    = "#{key}="
          query_arg_index = parts.index query_setter 
          query_arg_index = parts.index "&#{query_setter}" if !query_arg_index # handle case of ampersand

          if query_arg_index != nil
            parts[query_arg_index+1] = value
          end
        end
      end
    end

    parts.join("")
  end

  def inject_client_id_and_api_key(post_query)
    post_query
      .gsub(CLIENT_ID_GSUB, "client_id=#{client_id}")
      .gsub(API_KEY_GSUB, "api_key=#{api_key}")
  end

  private

  def setup_request!
    options = {
      :headers  =>  {'Accept' => "application/json"},
      :ssl      =>  {:verify => false},
      :url      =>  Digitalocean.api_endpoint,
      :params   =>  Digitalocean.credential_attrs 
    }

    Digitalocean.request = ::Faraday::Connection.new(options) do |builder|
      builder.use     ::Faraday::Request::UrlEncoded
      builder.use     ::FaradayMiddleware::ParseJson
      builder.use     ::FaradayMiddleware::FollowRedirects
      builder.adapter ::Faraday.default_adapter
    end
  end
end
