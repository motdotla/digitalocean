require "faraday"
require "faraday_middleware"
require "recursive-open-struct"
require "digitalocean/version"

module Digitalocean
  extend self

  DEFINITIONS     = {
    "Domain"  => {
      "all"       => "https://api.digitalocean.com/v1/domains?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"      => "https://api.digitalocean.com/v1/domains/[domain_id]?client_id=[your_client_id]&api_key=[your_api_key]",
      "create"    => "https://api.digitalocean.com/v1/domains/new?client_id=[your_client_id]&api_key=[your_api_key]&name=[domain]&ip_address=[ip_address]",
      "destroy"   => "https://api.digitalocean.com/v1/domains/[domain_id]/destroy?client_id=[your_client_id]&api_key=[your_api_key]"
    },
    "Droplet" => {
      "all"       => "https://api.digitalocean.com/v1/droplets/?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"      => "https://api.digitalocean.com/v1/droplets/[droplet_id]?client_id=[your_client_id]&api_key=[your_api_key]",
      "rename"    => "https://api.digitalocean.com/v1/droplets/[droplet_id]/rename/?client_id=[your_client_id]&api_key=[your_api_key]&name=[name]",
      "rebuild"   => "https://api.digitalocean.com/v1/droplets/[droplet_id]/rebuild/?image_id=[image_id]&client_id=[client_id]&api_key=[api_key]",
      "reboot"    => "https://api.digitalocean.com/v1/droplets/[droplet_id]/reboot/?client_id=[your_client_id]&api_key=[your_api_key]",
      "power_cycle" => "https://api.digitalocean.com/v1/droplets/[droplet_id]/power_cycle/?client_id=[your_client_id]&api_key=[your_api_key]",
      "shutdown" => "https://api.digitalocean.com/v1/droplets/[droplet_id]/shutdown/?client_id=[your_client_id]&api_key=[your_api_key]",
      "power_off" => "https://api.digitalocean.com/v1/droplets/[droplet_id]/power_off/?client_id=[your_client_id]&api_key=[your_api_key]",
      "power_on"  => "https://api.digitalocean.com/v1/droplets/[droplet_id]/power_on/?client_id=[your_client_id]&api_key=[your_api_key]",
      "snapshot"  => "https://api.digitalocean.com/v1/droplets/[droplet_id]/snapshot/?name=[snapshot_name]&client_id=[your_client_id]&api_key=[your_api_key]",
      "create"    => "https://api.digitalocean.com/v1/droplets/new?client_id=[your_client_id]&api_key=[your_api_key]&name=[droplet_name]&size_id=[size_id]&image_id=[image_id]&region_id=[region_id]&ssh_key_ids=[ssh_key_ids]&private_networking=[private_networking]&backups_enabled=[backups_enabled]", # unique case that is not copy/paste
      "destroy"   => "https://api.digitalocean.com/v1/droplets/[droplet_id]/destroy/?client_id=[your_client_id]&api_key=[your_api_key]",
      "resize"   => "https://api.digitalocean.com/v1/droplets/[droplet_id]/resize/?size_id=[size_id]&client_id=[client_id]&api_key=[api_key]"
    },
    "Image"   => {
      "all"       => "https://api.digitalocean.com/v1/images/?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"      => "https://api.digitalocean.com/v1/images/[image_id]/?client_id=[your_client_id]&api_key=[your_api_key]",
      "destroy"      => "https://api.digitalocean.com/v1/images/[image_id]/destroy/?client_id=[your_client_id]&api_key=[your_api_key]",
      "transfer"      => "https://api.digitalocean.com/v1/images/[image_id]/transfer/?client_id=[your_client_id]&api_key=[your_api_key]&region_id=[region_id]"
    },
    "Record"  => {
      "all"       => "https://api.digitalocean.com/v1/domains/[domain_id]/records?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"       => "https://api.digitalocean.com/v1/domains/[domain_id]/records/[record_id]?client_id=[your_client_id]&api_key=[your_api_key]",
      "create"     => "https://api.digitalocean.com/v1/domains/[domain_id]/records/new?client_id=[your_client_id]&api_key=[your_api_key]&record_type=[record_type]&data=[data]",
      "edit"       => "https://api.digitalocean.com/v1/domains/[domain_id]/records/[record_id]/edit?client_id=[your_client_id]&api_key=[your_api_key]",
      "destroy"    => "https://api.digitalocean.com/v1/domains/[domain_id]/records/[record_id]/destroy?client_id=[your_client_id]&api_key=[your_api_key]"
    },
    "Region"  => {
      "all"       => "https://api.digitalocean.com/v1/regions/?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"       => "https://api.digitalocean.com/v1/regions/[region_id]?client_id=[your_client_id]&api_key=[your_api_key]"
    },
    "Size"    => {
      "all"       => "https://api.digitalocean.com/v1/sizes/?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"       => "https://api.digitalocean.com/v1/sizes/[size_id]?client_id=[your_client_id]&api_key=[your_api_key]"
    },
    "SshKey"  => {
      "all"       => "https://api.digitalocean.com/v1/ssh_keys/?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"      => "https://api.digitalocean.com/v1/ssh_keys/[ssh_key_id]/?client_id=[your_client_id]&api_key=[your_api_key]",
      "edit"      => "https://api.digitalocean.com/v1/ssh_keys/[ssh_key_id]/edit/?name=[ssh_key_name]&ssh_pub_key=[ssh_public_key]&client_id=[client_id]&api_key=[api_key]",
      "create"    => "https://api.digitalocean.com/v1/ssh_keys/new/?name=[ssh_key_name]&ssh_pub_key=[ssh_public_key]&client_id=[your_client_id]&api_key=[your_api_key]",
     "destroy"   => "https://api.digitalocean.com/v1/ssh_keys/[ssh_key_id]/destroy/?client_id=[your_client_id]&api_key=[your_api_key]"
    },
    "Event"   => {
      "find"      => "https://api.digitalocean.com/v1/events/[event_id]/?client_id=[your_client_id]&api_key=[your_api_key]"
    }
  }

  DEFINITIONS.each do |resource|
    resource_name = resource[0]

    resource_class = Class.new(Object) do
      # http://stackoverflow.com/questions/3026943/define-method-for-instance-of-class
      singleton = class << self; self end

      DEFINITIONS[resource_name].each do |method_name, url|
        parts         = url.split("?")
        pre_query     = parts[0]
        post_query    = parts[1]

        singleton.send :define_method, "_#{method_name}" do |*args|
          pre_query_for_method   = Digitalocean.process_standard_args_from_part(pre_query, args)
          post_query_for_method  = Digitalocean.process_hash_args_from_part(post_query, args)

          [pre_query_for_method, post_query_for_method].join("?")
        end

        singleton.send :define_method, method_name do |*args|
          Digitalocean.request_and_respond send("_#{method_name}", *args)
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

  def request_and_respond(url)
    resp = Digitalocean.request.get url
    hash = RecursiveOpenStruct.new(resp.body, :recurse_over_arrays => true)

    hash
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
    parts[client_id_index+1] = client_id if client_id_index

    api_key_index = parts.index "api_key="
    api_key_index = parts.index "&api_key=" if !api_key_index
    parts[api_key_index+1] = api_key if api_key_index

    parts
  end

  def process_hash_args_from_part(part, args)
    parts = part.split(/\[|\]/)
    parts = process_client_id_and_api_key(parts)

    hash = args[-1]
    if hash.is_a?(Hash)
      if parts.length > 1
        hash.each do |key, value|
          query_setter    = "#{key}="
          query_arg_index = parts.index query_setter
          query_arg_index = parts.index "&#{query_setter}" if !query_arg_index # handle case of ampersand

          if query_arg_index != nil
            parts[query_arg_index+1] = value
            hash.delete(key) # cleanup
          end
        end
      end

      # append any additional hash arguments (optional params)
      hash.each do |key, value|
        appendable_param = "&#{key}=#{value}"
        parts.push(appendable_param)
      end
    end

    parts.join("")
  end

  private

  def setup_request!
    options = {
      :headers  =>  {'Accept' => "application/json"},
      :ssl      =>  {:verify => false}
    }

    Digitalocean.request = ::Faraday::Connection.new(options) do |builder|
      builder.use     ::Faraday::Request::UrlEncoded
      builder.use     ::FaradayMiddleware::ParseJson
      builder.use     ::FaradayMiddleware::FollowRedirects
      builder.adapter ::Faraday.default_adapter
    end
  end
end
