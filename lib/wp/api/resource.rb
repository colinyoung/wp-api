require 'active_support/inflector'

module WP::API
  class Resource
    attr_reader :attributes, :headers

    def initialize(attributes, headers = {})
      raise ResourceNotFoundError.new(self.class.name) if attributes.nil?
      @attributes = attributes
      @headers = _downcase_keys(headers).slice("link") if headers
    end

    def id
      attributes['ID']
    end

    protected

    def method_missing(key, new_value = nil)
      key = key.to_s
      determinant = key[-1]
      case determinant
      when '?' # example: post.sticky?
        attributes[key.chomp(determinant)] == true
      when '!' # unsupported
        fail NoMethodError.new(key)
      when '=' # example: post.title = 'my new title'
        attributes[key.chomp(determinant)] = new_value
      else
        # All other values. Hashes are converted to objects
        # if a resource for them exists (e.g. Authors)
        object key, attributes[key]
      end
    end

    private

    def to_s
      attributes.to_s
    end

    def object(key, value)
      klass = key.classify
      if value.is_a?(Hash) && WP::API.const_defined?(klass)
        resource = WP::API.const_get(klass)
        resource.new(value)
      else
        value
      end
    end

    def _remove_entities(string)
      HTMLEntities.new.decode(string.gsub('&amp;','&'))
    end

    def _downcase_keys(hash)
      Hash.new.tap do |new_hash|
        hash.each do |k, v|
          new_hash[k.downcase] = v
        end
      end
    end
  end
end
