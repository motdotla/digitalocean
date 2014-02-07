require "faraday"
require "faraday_middleware"
require "recursive-open-struct"
require "digitalocean/version"
require "digitalocean/droplet"
require "digitalocean/image"
require "digitalocean/region"
require "digitalocean/size"
require "digitalocean/ssh_key"
require "digitalocean/domain"
require "digitalocean/record"


module Digitalocean
  extend self

  CLIENT_ID_GSUB  = "client_id=[your_client_id]"
  API_KEY_GSUB    = "api_key=[your_api_key]"

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

  def process_args_from_part(part, args)
    parts = part.split(/\[|\]/)

    if parts.length > 1
      parts.each_with_index do |v, i|
        is_every_other = (i%2 == 1)
        parts[i] = args.shift if is_every_other
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
