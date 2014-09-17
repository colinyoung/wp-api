require 'fakeweb'

class MockWordpressServer
  include FilesHelper

  attr_reader :host

  def initialize(host: 'wp.example.com')
    @host = host

    register_all
  end

  protected

  def register_all
    FakeWeb.register_uri(:get, "http://#{host}/wp-json/posts", :body => support_file("posts.json"))
  end
end
