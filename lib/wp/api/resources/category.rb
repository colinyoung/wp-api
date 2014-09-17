module WP::API
  class Category < Resource
    def to_param
      slug
    end
  end
end
