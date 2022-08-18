module Spina
  module Pages
    class PageComponent < ApplicationComponent
      attr_reader :sortable, :draggable
  
      def initialize(page:, sortable: true, draggable: true)
        @page = page
        @sortable = sortable
        @draggable = draggable
      end
      
      def label
        labels = []
        labels << t("spina.pages.concept") if @page.draft?
        labels << t("spina.pages.show_in_menu") unless @page.show_in_menu?
        labels << t("spina.pages.skip_to_first_child") if @page.skip_to_first_child?
        return nil if labels.size.zero?
        "(#{labels.join(", ")})"
      end
      
      def sortable?
        sortable
      end
      
      def draggable?
        draggable
      end
  
      def depth
        @page.depth
      end
      
      def css_class
        case depth
        when 1
          "pl-5 bg-gray-100"
        when 2
          "pl-10 bg-gray-200"
        end
      end
  
      def children
        @children ||= @page.children.active.sorted
      end
  
    end
  end
end