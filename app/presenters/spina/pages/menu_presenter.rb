require 'active_support/configurable'
require 'action_view/helpers/tag_helper'
require 'action_view/helpers/url_helper'

module Spina
  module Pages
    class MenuPresenter
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::UrlHelper
      include ActiveSupport::Configurable

      config_accessor :list_tag, :list_class, :list_item_tag, :list_item_css, :selected_css, :current_css

      self.list_tag = :ul
      self.list_class = 'nav'
      self.list_item_tag = :li
      self.list_item_css = nil
      self.selected_css = 'active'
      self.current_css = 'current'

      attr_accessor :context, :collection, :current_menu_item
      delegate :output_buffer, :output_buffer=, to: :context

      def initialize(collection, context, current_menu_item = nil)
        @collection = collection
        @context = context
        @current_menu_item = current_menu_item
        @selected_menu_items = [@current_menu_item] + @current_menu_item.try(:ancestors)
      end

      def to_html
        render_menu_items(collection) if collection.present?
      end

      private

        def render_menu_items(menu_items)
          content_tag(list_tag, class: list_class) do
            menu_items.each.inject(ActiveSupport::SafeBuffer.new) do |buffer, item|
              buffer << render_menu_item(item)
            end
          end
        end

        def render_menu_item(menu_item)
          content_tag(list_item_tag, class: menu_item_css(menu_item[0])) do
            buffer = ActiveSupport::SafeBuffer.new
            buffer << link_to(menu_item[0].menu_title, menu_item[0].materialized_path)
            buffer << render_menu_items(menu_item[1]) if menu_item[1].present?
            buffer
          end
        end

        def menu_item_css(menu_item)
          css = [list_item_css]
          css << selected_css if (@selected_menu_items.present? && @selected_menu_items.include?(menu_item) )
          css << current_css if @current_menu_item == menu_item
          css
        end

    end
  end
end
