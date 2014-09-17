require 'httparty'
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
      response = Client.get(path)
      if response.empty?
        raise WP::API::ResourceNotFoundError
      else
        response.parsed_response # Already parsed.
      end
    end

    private

    def url_for(fragment, query)
      url = "#{@scheme}://#{@host}/wp-json/#{fragment}"
      url << ("?" + params(query)) unless query.empty?

      url
    end

    def params(query)
      uri = Addressable::URI.new
      filter_hash = {}
      query.each do |key, value|
        filter_hash["filter[#{key}]"] = value
      end
      uri.query_values = filter_hash

      uri.query
    end
  end
end
