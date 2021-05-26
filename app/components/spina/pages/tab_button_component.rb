module Spina
  module Pages
    class TabButtonComponent < ApplicationComponentq
      def initialize(page:, locale:, tab_name:)
        @page = page
        @locale = locale
        @tab_name = tab_name
      end

      def icon_name
        case @tab_name
        when 'page_content'
          'document-text'
        when 'search_engines'
          'search'
        when 'advanced'
          'cog'
        end
      end
    end
  end
end