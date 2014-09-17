require 'httparty'
require 'yajl'

module WP::API
  class Client
    include HTTParty

    attr_accessor :host

    def initialize(host:, scheme: 'http')
      @scheme = scheme
      @host = host
      fail ':host is required' unless host.is_a?(String) && host.length > 0
    end

    def posts
      index(:posts).collect do |hash|
        Post.new(hash)
      end
    end

    protected

    def index(resource)
      path = path_to_url(resource)
      body = Client.get(path).body
      parse(body)
    end

    private

    def path_to_url(fragment)
      "#{@scheme}://#{@host}/wp-json/#{fragment}"
    end

    def parse(string)
      @parser ||= Yajl::Parser.new
      @parser.parse(string)
    end
  end
end
