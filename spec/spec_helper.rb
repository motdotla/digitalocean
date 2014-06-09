require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'digitalocean'
require 'securerandom'
require 'rspec/its'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}
