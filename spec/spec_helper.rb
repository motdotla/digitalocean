require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'digitalocean'
require 'securerandom'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

RSpec.configure do |config|
  config.before(:suite) do
    # FakeWeb.allow_net_connect = false
    set_client_id_and_api_key!
  end

  # config.after(:suite) do
  #   FakeWeb.allow_net_connect = true
  # end
end

def set_client_id_and_api_key!
  Digitalocean.client_id  = ENV['DIGITALOCEAN_CLIENT_ID']
  Digitalocean.api_key    = ENV['DIGITALOCEAN_API_KEY']
end