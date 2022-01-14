module Spina
  module Accounts
    class TranslationsComponent < ApplicationComponent
  
      def initialize(account, label: nil)
        @account = account
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