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

    def post_meta(id, query = {})
      resource_subpath('posts', id, 'meta', query).first
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

    def item_named(slug)
      begin
        item = resource_named('posts', slug)
      rescue WP::API::ResourceNotFoundError
        item = resource_named('pages', slug)
      end
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

    def resource_subpath(res, id, subpath, query = {})
      query.merge(should_raise_on_empty: false)
      get("#{res}/#{id}/#{subpath}", query)
    end

    def resource_named(res, slug)
      resources(res, name: slug).first
    end

    def resource_class(res)
      WP::API::const_get(res.classify)
    end

  end
end
