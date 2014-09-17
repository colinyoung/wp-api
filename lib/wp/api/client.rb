require 'httparty'
require 'yajl'
require 'addressable/uri'
require 'wp/api/endpoints'

module WP::API
  class Client
    include HTTParty
    include Endpoints

    attr_accessor :host

    def initialize(host:, scheme: 'http')
      @scheme = scheme
      @host = host
      fail ':host is required' unless host.is_a?(String) && host.length > 0
    end

    protected

    def get(resource, query = {})
      path = url_for(resource, query)
      body = Client.get(path).body
      parse(body)
    end

    private

    def url_for(fragment, query)
      url = "#{@scheme}://#{@host}/wp-json/#{fragment}"
      url << ("?" + params(query)) unless query.empty?

      url
    end

    def params(query)
      uri = Addressable::URI.new
      uri.query_values = query
      uri.query
    end

    def parse(string)
      @parser ||= Yajl::Parser.new
      @parser.parse(string)
    end
  end
end
