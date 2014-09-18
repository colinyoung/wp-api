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
    FakeWeb.register_uri(:get, "http://#{host}/wp-json/posts", :body => support_file("posts.json"), :content_type => "application/json", :link => support_file("posts.header.txt"))
    FakeWeb.register_uri(:get, "http://#{host}/wp-json/posts/1", :body => support_file("posts/1.json"), :content_type => "application/json")
    FakeWeb.register_uri(:get, "http://#{host}/wp-json/posts/2", :body => support_file("posts/2.json"), :content_type => "application/json")
  end
end
