module Spina
  module Embeds
  
    def self.constantize(embeddable_type)
      return nil if embeddable_type.blank?
      name = embeddable_type.camelize.demodulize.to_s
      "Spina::Embeds::#{name}".safe_constantize
    end

  end
end