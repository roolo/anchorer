require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require_relative 'anchorer'
require 'digest/md5'
require 'redis'

module Anchorer
  class API < Sinatra::Base
    error do
      'Sorry there was a nasty error - ' + env['sinatra.error'].message
    end
    configure do
      @@redis = Redis.new host: 'localhost'
    end
    configure :test do
      set :show_exceptions, false
    end

    get '/anchorize' do
      return '<i>url</i> not given' if params[:url].nil?
      url_hash = Digest::MD5.hexdigest params[:url]
      url_storage_key = 'anchorer-'+url_hash

      unless @@redis[url_storage_key]
        anchorer = ::Anchorer::Anchorer.new params[:url]

        @@redis[url_storage_key] = anchorer.modify anchorer.content
        # store page for a week
        @@redis.expire url_storage_key, 604800
      end

      @@redis[url_storage_key]
    end
  end
end
