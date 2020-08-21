module Spina
  module TranslatedContent
    extend ActiveSupport::Concern

    included do
      
      # Store each locale's content in [locale]_content as an array of parts
      Spina.config.locales.each do |locale|
        attr_json "#{locale}_content".to_sym, AttrJson::Type::SpinaPartsModel.new, array: true, default: -> { [] }
        attr_json_accepts_nested_attributes_for "#{locale}_content".to_sym
      end

      def find_part(name)
        send("#{I18n.locale}_content").find{|part| part.name.to_s == name.to_s}
      end

    end
  end
end