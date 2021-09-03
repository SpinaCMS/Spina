module Spina
  module Embeddable
    extend ActiveSupport::Concern
    
    included do
      class_attribute :embed_attributes, default: []
      class_attribute :icon, default: nil
    end
    
    class_methods do
      def from_json(json)
        begin
          attributes = JSON.parse(json)
          attributes.transform_keys!(&:to_sym)
          new(attributes)
        rescue 
          Rails.logger.error "[#{self.class.name}] Couldn't parse JSON"
        end
      end
      
      def attributes(*names)
        attr_accessor(*names.map(&:to_sym))
        self.embed_attributes += names.map(&:to_sym)
      end
      
      # Give it an icon
      def heroicon(name)
        self.icon = name
      end
    end
    
    def initialize(attributes = {})
      attributes.slice(*self.class.embed_attributes).each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
    
    def to_fields_path
      "#{to_partial_path}_fields"
    end
    
    def to_trix_partial_path
      to_partial_path
    end
    
  end
end