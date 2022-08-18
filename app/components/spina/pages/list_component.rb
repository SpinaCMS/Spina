module Spina
  module Pages
    class ListComponent < ApplicationComponent
      attr_reader :depth, :sortable, :draggable, :paginated
  
      def initialize(pages:, sortable: true, draggable: nil)
        @pages = pages
        @sortable = sortable
        
        # List of pages is only draggable if there's no pagination
        @paginated = pages.respond_to?(:total_pages)
        @draggable = draggable
        @draggable = !paginated || pages.total_pages == 1 if draggable.nil?
      end
  
    end
  end
end