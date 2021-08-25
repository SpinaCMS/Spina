module Spina::Embeddable
  class Youtube < Base
    ATTRIBUTES = [:id, "id"]
    attr_accessor *ATTRIBUTES
    
    def initialize(attributes = {})
      attributes.slice(*ATTRIBUTES).each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
    
    def to_partial_path
      "spina/embeddable/youtube"
    end
    
    def to_fields_path
      "spina/embeddable/fields/youtube_fields"
    end
    
    def to_trix_partial_path
      "spina/embeddable/trix/youtube"
    end
    
  end
end