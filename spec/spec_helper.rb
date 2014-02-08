require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'digitalocean'
require 'securerandom'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

RSpec.configure do |config|
  config.before(:suite) do
  end
end

