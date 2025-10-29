module Spina
  class MenuPresenter
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::UrlHelper

    attr_accessor :collection, :output_buffer

    # Configuration
    class_attribute :menu_tag, default: :nav
    class_attribute :menu_css
    class_attribute :list_tag, default: :ul
    class_attribute :list_css
    class_attribute :list_item_tag, default: :li
    class_attribute :list_item_css
    class_attribute :link_tag_css
    class_attribute :active_list_item_css
    class_attribute :current_list_item_css
    class_attribute :include_drafts, default: false
    class_attribute :depth # root nodes are at depth 0

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
      return nil unless item.materialized_path

      children = scoped_collection(item.children)

      content_tag(list_item_tag, class: item_css(item), data: {page_id: item.page_id, draft: (true if item.draft?)}) do
        buffer = ActiveSupport::SafeBuffer.new
        buffer << link_to(item.menu_title, item.materialized_path, class: link_tag_css)
        buffer << render_items(children) if render_children?(item) && children.any?
        buffer
      end
    end

    def scoped_collection(collection)
      scoped = collection.active.in_menu.sorted
      include_drafts ? scoped : scoped.live
    end

    def render_children?(item)
      return true unless depth
      item.depth < depth
    end

    def item_css(item)
      return current_list_item_css if apply_current_css?(item)
      return active_list_item_css if apply_active_css?(item)
      list_item_css
    end

    def apply_current_css?(item)
      return false if current_list_item_css.nil?
      Spina::Current.page == item
    end

    def apply_active_css?(item)
      return false if apply_current_css?(item)
      parent_of_current?(item)
    end

    def parent_of_current?(item)
      return false if item.homepage?
      Spina::Current.page.materialized_path.starts_with? item.materialized_path
    end
  end
end
