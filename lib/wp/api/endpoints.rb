module WP::API
  module Endpoints

    def posts(query = {})
      resources('posts', query)
    end

    def post(id, query = {})
      resource('posts', id, query)
    end

    def post_named(slug)
      resource_named('posts', slug)
    end

    def pages(query = {})
      resources('pages', query)
    end

    def page(id, query = {})
      resource('pages', id, query)
    end

    def page_named(slug)
      resource_named('pages', slug)
    end

    private

    def resources(res, query = {})
      resources, headers = get(res, query)
      resources.collect do |hash|
        resource_class(res).new(hash, headers)
      end
    end

    def resource(res, id, query = {})
      resource_class(res).new *get("#{res}/#{id}", query)
    end

    def resource_named(res, slug)
      resources(res, name: slug).first
    end

    def resource_class(res)
      WP::API::const_get(res.classify)
    end

  end
end
