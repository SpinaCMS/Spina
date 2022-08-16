module Spina
  module Pages
    class ListComponent < ApplicationComponent
      attr_reader :depth, :sortable, :draggable
  
      def initialize(pages:, sortable: true)
        @pages = pages
        @sortable = sortable
        
        # List of pages is only draggable if there's no pagination
        @draggable = pages.total_pages == 1
      end
  
    end
  end
end