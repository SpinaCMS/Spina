module Spina
  module Embeddable
    extend ActiveSupport::Concern
    
    included do
      class_attribute :embed_attributes, default: []
    end
    
    class_methods do
      def from_data_attributes(data_attributes = {})
        data_attributes.transform_keys! do |key|
          key.remove(/\Adata\-/).underscore.to_sym
        end
        data_attributes.transform_values!(&:to_s)
        new(data_attributes)
      end
      
      def attributes(name)
        attr_accessor(name.to_sym)
        self.embed_attributes << name.to_sym
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