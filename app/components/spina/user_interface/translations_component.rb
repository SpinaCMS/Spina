module Spina
  module UserInterface
    class TranslationsComponent < ApplicationComponent
      def initialize(record, label: nil)
        @record = record
        @label = label
      end

      def render?
        spina_locales.many?
      end

      def locales
        spina_locales
      end

      private

      def spina_locales
        Spina.config.locales.map(&:to_sym)
      end
    end
  end
end
