module WP::API
  class Post < Resource
    def categories
      terms['category'].collect {|cat| WP::API::Category.new(cat) }
    end
  end
end
