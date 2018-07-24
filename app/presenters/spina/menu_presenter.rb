module Spina
  class MenuPresenter
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::UrlHelper
    include ActiveSupport::Configurable

    attr_accessor :collection, :output_buffer

    # Configuration
    config_accessor :menu_tag, :menu_css,
                    :list_tag, :list_css, 
                    :list_item_tag, :list_item_css, 
                    :link_tag_css,
                    :include_drafts,
                    :depth # root nodes are at depth 0

    # Default configuration
    self.menu_tag = :nav
    self.list_tag = :ul
    self.list_item_tag = :li
    self.include_drafts = false

    def initialize(collection)
      @collection = collection
    end

    def to_html
      render_menu(roots)
    end

    private

      def roots
        return collection.navigation_items.roots if collection.is_a?(Navigation)
        collection.roots
      end

      def render_menu(collection)
        content_tag(menu_tag, class: menu_css) do
          render_items(scoped_collection(collection))
        end
      end

      def render_items(collection)
        content_tag(list_tag, class: list_css) do
          collection.inject(ActiveSupport::SafeBuffer.new) do |buffer, item|
            buffer << render_item(item)
          end
        end
      end

      def render_item(item)
        children = scoped_collection(item.children)

        content_tag(list_item_tag, class: list_item_css, data: {page_id: item.page_id, draft: (true if item.draft?) }) do
          buffer = ActiveSupport::SafeBuffer.new
          buffer << link_to(item.menu_title, item.materialized_path, class: link_tag_css)
          buffer << render_items(children) if render_children?(item) && children.any?
          buffer
        end
      end

      def scoped_collection(collection)
        scoped = collection.regular_pages.active.in_menu.sorted
        include_drafts ? scoped : scoped.live
      end

      def render_children?(item)
        return true unless depth
        item.depth < depth
      end

  end
end