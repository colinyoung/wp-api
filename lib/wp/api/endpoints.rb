module WP::API
  module Endpoints

    def posts(query = {})
      get("posts", query).collect do |hash|
        WP::API::Post.new(hash)
      end
    end

    def post(id, query = {})
      WP::API::Post.new get("posts/#{id}", query)
    end

    def post_named(slug)
      WP::API::Post.new get("posts", name: slug).first
    end

  end
end
