module WP::API
  module Endpoints

    def posts(query = {})
      posts, headers = get("posts", query)
      posts.collect do |hash|
        WP::API::Post.new(hash, headers)
      end
    end

    def post(id, query = {})
      WP::API::Post.new *get("posts/#{id}", query)
    end

    def post_named(slug)
      posts(name: slug).first
    end

  end
end
