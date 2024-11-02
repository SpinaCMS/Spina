module Spina
  module TranslatedContent
    extend ActiveSupport::Concern

    include Spina::AttrJsonMonkeypatch

    included do
      # Store each locale's content in [locale]_content as an array of parts
      Spina.locales.each do |locale|
        attr_json "#{locale.to_s.underscore}_content".to_sym, AttrJson::Type::SpinaPartsModel.new, array: true, default: -> { [] }
        attr_json_setter_monkeypatch "#{locale.to_s.underscore}_content".to_sym
        attr_json_accepts_nested_attributes_for "#{locale.to_s.underscore}_content".to_sym
      end
    end

    def find_part(name)
      send("#{I18n.locale.to_s.underscore}_content").find { |part| part.name.to_s == name.to_s }
    end
  end
end
