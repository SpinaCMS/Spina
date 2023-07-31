module Spina
  module NavigationItems
    class TranslationsComponent < ApplicationComponent
      def initialize(label: nil, navigation:, navigation_item:)
        @label = label
        @navigation = navigation
        @navigation_item = navigation_item
      end

      def render?
        spina_locales.many?
      end

      def missing_locales
        spina_locales - existing_locales
      end

      def locales
        spina_locales
      end

      def existing_locales
        @existing_locales ||= @navigation_item.translations.pluck(:locale).map(&:to_sym).sort_by do |locale|
          spina_locales.index(locale)
        end
      end

      private

      def spina_locales
        Spina.locales.map(&:to_sym)
      end
    end
  end
end
