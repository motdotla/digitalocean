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
    "missing_client_id"
  end

  def api_key=(api_key)
    @api_key = api_key
    setup_request!

    @api_key
  end

  def api_key
    return @api_key if @api_key
    "missing_api_key"
  end

  def api_endpoint
    "https://api.digitalocean.com"
  end

  def credential_attrs
    {:client_id => Digitalocean.client_id, :api_key => Digitalocean.api_key}
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