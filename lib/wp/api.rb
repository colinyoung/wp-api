require 'wp/api/version'
require 'wp/api/errors'
require 'wp/api/resource'
Dir[File.expand_path(File.dirname(__FILE__) + '/api/resources/*.rb')].each {|resource| require resource }
require 'wp/api/client'

require 'httparty'

module WP
  module API
    def self.[](host)
      Client.new(host: host)
    end
  end
end
