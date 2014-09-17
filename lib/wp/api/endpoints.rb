module WP::API
  module Endpoints

    def posts(query = {})
      get("posts", query).collect do |hash|
        Post.new(hash)
      end
    end

    def post(id, query = {})
      hash = get("posts/#{id}", query)
      Post.new(hash)
    end

  end
end
