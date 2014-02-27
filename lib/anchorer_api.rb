require 'sinatra'
require_relative 'anchorer'

module Anchorer
  class API < Sinatra::Base
    error do
      'Sorry there was a nasty error - ' + env['sinatra.error'].message
    end
    configure :test do
      set :show_exceptions, false
    end

    get '/anchorize' do
      return '<i>url</i> not give' if params[:url].nil?

      anchorer = ::Anchorer::Anchorer.new params[:url]

      anchorer.modify anchorer.content
    end
  end
end
