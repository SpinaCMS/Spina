module Spina
  module Pages
    class ActionsComponent < ApplicationComponent
      
      def initialize(page:, locale: I18n.locale)
        @page = page
        @locale = locale
      end
      
    end
  end
end