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
      redis_uri = URI.parse ENV['REDIS_URL'] || 'localhost'
      @@redis = Redis.new host:     redis_uri.host,
                          port:     redis_uri.port,
                          password: redis_uri.password
    end
    configure :test do
      set :show_exceptions, false
    end

    get '/anchorize' do
      return '<i>url</i> not given' if params[:url].nil?
      url_hash = Digest::MD5.hexdigest params[:url]
      url_storage_key = 'anchorer-'+url_hash

      unless @@redis[url_storage_key] && false
        anchorer = ::Anchorer::Anchorer.new params[:url]

        @@redis[url_storage_key] = anchorer.modify anchorer.content
      end
      # store page for another week
      @@redis.expire url_storage_key, 604800

      @@redis[url_storage_key]
    end

    get '/' do
      File.read(File.expand_path './lib/home.html')
    end
  end
end
