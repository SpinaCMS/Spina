module Spina
  module Navigations
    class TranslationsComponent < ApplicationComponent
      def initialize(label: nil, navigation:, locale:)
        @label = label
        @navigation = navigation
        @locale = locale
      end

      def render?
        spina_locales.many?
      end

      def missing_locales
        spina_locales - completed_locales
      end

      def locales
        spina_locales
      end

      def completed_locales
        all_locales = spina_locales
        spina_locales.each do |locale|
          t = @navigation.navigation_items.urls.map(&:translations).map do |translations|
            translations.any? {|translation| translation.url_title.present? && translation.locale.to_sym == locale }
          end
          
          all_locales.delete(locale) if t.any?(false)
        end
        all_locales
      end

      private

      def spina_locales
        Spina.locales.map(&:to_sym)
      end
    end
  end
end
