require "faraday"
require "faraday_middleware"
require "recursive-open-struct"
require "digitalocean/version"

module Digitalocean
  extend self

  RESOURCES = {
    "Domain"  => {
      "all"         => "/domains?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"        => "/domains/[domain_id]?client_id=[your_client_id]&api_key=[your_api_key]",
      "create"      => "/domains/new?client_id=[your_client_id]&api_key=[your_api_key]&name=[domain]&ip_address=[ip_address]",
      "destroy"     => "/domains/[domain_id]/destroy?client_id=[your_client_id]&api_key=[your_api_key]"
    },
    "Droplet" => {
      "all"         => "/droplets/?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"        => "/droplets/[droplet_id]?client_id=[your_client_id]&api_key=[your_api_key]",
      "rename"      => "/droplets/[droplet_id]/rename/?client_id=[your_client_id]&api_key=[your_api_key]&name=[name]",
      "reboot"      => "/droplets/[droplet_id]/reboot/?client_id=[your_client_id]&api_key=[your_api_key]",
      "power_cycle" => "/droplets/[droplet_id]/power_cycle/?client_id=[your_client_id]&api_key=[your_api_key]",
      "shutdown"    => "/droplets/[droplet_id]/shutdown/?client_id=[your_client_id]&api_key=[your_api_key]",
      "power_off"   => "/droplets/[droplet_id]/power_off/?client_id=[your_client_id]&api_key=[your_api_key]",
      "power_on"    => "/droplets/[droplet_id]/power_on/?client_id=[your_client_id]&api_key=[your_api_key]",
      "snapshot"    => "/droplets/[droplet_id]/snapshot/?name=[snapshot_name]&client_id=[your_client_id]&api_key=[your_api_key]",
      "create"      => "/droplets/new?client_id=[your_client_id]&api_key=[your_api_key]&name=[droplet_name]&size_id=[size_id]&image_id=[image_id]&region_id=[region_id]&ssh_key_ids=[ssh_key_ids]&private_networking=[private_networking]&backups_enabled=[backups_enabled]", # unique case that is not copy/paste
      "destroy"     => "/droplets/[droplet_id]/destroy/?client_id=[your_client_id]&api_key=[your_api_key]"
    },
    "Image"   => {
      "all"         => "/images/?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"        => "/images/[image_id]/?client_id=[your_client_id]&api_key=[your_api_key]",
      "destroy"     => "/images/[image_id]/destroy/?client_id=[your_client_id]&api_key=[your_api_key]",
      "transfer"    => "/images/[image_id]/transfer/?client_id=[your_client_id]&api_key=[your_api_key]&region_id=[region_id]"
    },
    "Record"  => {
      "all"         => "/domains/[domain_id]/records?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"        => "/domains/[domain_id]/records/[record_id]?client_id=[your_client_id]&api_key=[your_api_key]",
      "create"      => "/domains/[domain_id]/records/new?client_id=[your_client_id]&api_key=[your_api_key]&record_type=[record_type]&data=[data]",
      "edit"        => "/domains/[domain_id]/records/[record_id]/edit?client_id=[your_client_id]&api_key=[your_api_key]",
      "destroy"     => "/domains/[domain_id]/records/[record_id]/destroy?client_id=[your_client_id]&api_key=[your_api_key]"
    },
    "Region"  => {
      "all"         => "/regions/?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"        => "/regions/[region_id]?client_id=[your_client_id]&api_key=[your_api_key]"
    },
    "Size"    => {
      "all"         => "/sizes/?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"        => "/sizes/[size_id]?client_id=[your_client_id]&api_key=[your_api_key]"
    },
    "SshKey"  => {
      "all"         => "/ssh_keys/?client_id=[your_client_id]&api_key=[your_api_key]",
      "find"        => "/ssh_keys/[ssh_key_id]/?client_id=[your_client_id]&api_key=[your_api_key]",
      "create"      => "/ssh_keys/new/?name=[ssh_key_name]&ssh_pub_key=[ssh_public_key]&client_id=[your_client_id]&api_key=[your_api_key]"
    },
    "Event"   => {
      "find"        => "/events/[event_id]/?client_id=[your_client_id]&api_key=[your_api_key]"
    }
  }

  RESOURCES.each do |resource_name, resource_actions|
    resource_class = Class.new(Object) do
      # http://stackoverflow.com/questions/3026943/define-method-for-instance-of-class
      singleton = class << self; self end

      resource_actions.each do |action, url|
        path, query_string = url.split("?")

        singleton.send :define_method, "_#{action}" do |*args|
          Digitalocean.url_for_action(path, query_string, args)
        end

        singleton.send :define_method, action do |*args|
          Digitalocean.request_and_respond send("_#{action}", *args)
        end
      end
    end

    Digitalocean.const_set(resource_name, resource_class)
  end

  def url_for_action(path, query_string, args)
    path_for_action         = Digitalocean.process_standard_args_from_path(path, args)
    query_string_for_action = Digitalocean.process_hash_args_from_query_string(query_string, args)

    "#{Digitalocean.api_endpoint + path_for_action}?#{query_string_for_action}"
  end

  def process_standard_args_from_path(path, args)
    parts = Digitalocean.get_parts(path)

    if parts.length > 1
      parts.each_with_index do |v, i|
        is_every_other = (i % 2 == 1)
        parts[i] = args.shift if is_every_other
      end
    end

    parts.join("")
  end

  def get_parts(part)
    part.split(/\[|\]/)
  end

  def process_hash_args_from_query_string(query_string, args)
    parts = Digitalocean.get_parts(query_string)
    parts = process_client_id_and_api_key(parts)

    hash = args[-1]
    if hash.is_a?(Hash)
      if parts.length > 1
        hash.each do |key, value|
          query_setter    = "#{key}="
          query_arg_index = parts.index query_setter
          query_arg_index = parts.index "&#{query_setter}" if !query_arg_index # handle case of ampersand

          if query_arg_index != nil
            parts[query_arg_index + 1] = value
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

  def process_client_id_and_api_key(parts)
    # Begin by taking care of the client_id and api_key
    client_id_index = parts.index "client_id="
    client_id_index = parts.index "&client_id=" if !client_id_index
    parts[client_id_index + 1] = client_id if client_id_index

    api_key_index = parts.index "api_key="
    api_key_index = parts.index "&api_key=" if !api_key_index
    parts[api_key_index + 1] = api_key if api_key_index

    parts
  end

  def api_endpoint
    "https://api.digitalocean.com"
  end

  def request_and_respond(url)
    resp = Digitalocean.request.get url
    hash = RecursiveOpenStruct.new(resp.body, :recurse_over_arrays => true)

    hash
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
