module Spina
  module Pages
    class ListComponent < ApplicationComponent
      attr_reader :depth, :sortable
  
      def initialize(pages:, sortable: true)
        @pages = pages
        if @pages.total_pages > 1
          @sortable = false
        else
          @sortable = sortable
        end
      end
  
    end
  end
end