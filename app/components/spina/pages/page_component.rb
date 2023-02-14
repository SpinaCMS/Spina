module Spina
  module Pages
    class PageComponent < ApplicationComponent
      attr_reader :page, :sortable, :draggable

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
      
      # Pages are collapsed by default if they're inside a resource
      def collapsed?
        page.resource_id.present?
      end

      def depth
        page.ancestry_depth
      end

      def css_class
        case depth
        when 1
          "pl-5 bg-gray-100"
        when 2
          "pl-10 bg-gray-200"
        end
      end
      
      # Explicitly check for "== 0" to account for older
      # Spina setups where ancestry_children_count is still NULL
      def has_children?
        return false if page.ancestry_children_count == 0
        page.has_children?
      end

      def children
        @children ||= page.children.active.sorted
      end
    end
  end
end
