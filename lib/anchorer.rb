require 'open-uri'

module Anchorer
  class Anchorer
    attr_accessor :original_content
    attr_accessor :original_url

    def initialize url
      @original_url = URI URI.decode(url).strip

      raise 'Invalid url given!' unless @original_url.scheme.to_s =~ /^http/
    end

    def content
      @original_content ||= open(@original_url).read
      #@original_content ||= ''

      @original_content
    end

    def modify input_content
      # Prepend anchors to headers
      output_content = input_content.gsub /(<h\d{1})/ do |match|
        '<a name="heading-%s"></a>%s'%[Time.now.to_f.to_s,match]
      end

      # Fix adressess
      output_content.gsub! /((src|href)=")\//, '\\2="%s://%s/'%[@original_url.scheme, @original_url.host]

      output_content
    end

    def host

    end
  end
end
