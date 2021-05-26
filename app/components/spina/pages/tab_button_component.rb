module Spina
  module Pages
    class TabButtonComponent < ApplicationComponent
      def initialize(page:, tab_name:)
        @page = page
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
        else
          'exclamation-circle'
        end
      end
    end
  end
end