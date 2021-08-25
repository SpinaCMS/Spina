module Spina::Embeddable
  class Base    
    ATTRIBUTES = []

    def initialize(attributes = {})
      attributes.slice(*ATTRIBUTES).each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
    
    class << self
      def from_data_attributes(data_attributes = {})
        data_attributes.transform_keys! do |key|
          key.remove(/\Adata\-/).underscore.to_sym
        end
        data_attributes.transform_values!(&:to_s)
        new(data_attributes)
      end
    end
    
  end
end