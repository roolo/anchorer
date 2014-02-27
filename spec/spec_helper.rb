ENV['RACK_ENV'] = 'test'
require 'minitest/spec'
require 'minitest/autorun'
require 'rack/test'
require_relative '../lib/anchorer_api.rb'


def app
  Anchorer::API
end

