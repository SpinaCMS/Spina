module Spina::Embeddable
  class Youtube    
    ATTRIBUTES = [:id]
    
    attr_accessor *ATTRIBUTES
    
    def initialize(attributes = {})
      attributes.slice(*ATTRIBUTES).each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
    
    def self.from_data_attributes(data_attributes = {})
      data_attributes.transform_keys! do |key|
        key.remove(/\Adata\-/).underscore.to_sym
      end
      data_attributes.transform_values!(&:to_s)
      new(data_attributes)
    end
    
    def to_partial_path
      "spina/embeddable/youtube/youtube"
    end
    
    def to_form_path
      "spina/embeddable/youtube/form"
    end
    
    def to_trix_partial_path
      "spina/embeddable/youtube/trix"
    end
    
  end
end