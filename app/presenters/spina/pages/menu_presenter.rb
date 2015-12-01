# require 'active_support/core_ext/string'
require 'active_support/configurable'
require 'action_view/helpers/tag_helper'
require 'action_view/helpers/url_helper'

module Spina
  module Pages
    class MenuPresenter
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::UrlHelper
      include ActiveSupport::Configurable

      config_accessor :list_tag, :list_wrapper, :list_css, :list_item_tag, :list_item_css, :selected_css, :current_css, :first_css, :last_css

      self.list_tag = :ul
      self.list_item_tag = :li
      self.list_wrapper = false

      self.list_item_css = nil
      self.selected_css = :selected
      self.current_css = :current
      self.first_css = :first
      self.last_css = :last
      self.list_css = nil

      attr_accessor :context, :collection, :current_menu_item
      delegate :output_buffer, :output_buffer=, to: :context

      def initialize(collection, context, current_menu_item=nil)
        @collection = collection
        @context = context
        @current_menu_item = current_menu_item
        @selected_menu_items = [@current_menu_item] + @current_menu_item.try(:ancestors)
      end

      def set_menu_style(style)
        self.list_css = style[:list_css]
        self.list_item_css = style[:list_item_css]
      end

      def to_html
        render_list_wrapper(collection) if collection.present?
      end

      private

      def render_list_wrapper(menu_items)
        if menu_items.any?
          if list_wrapper
            content_tag(:div) do
              render_menu_items(menu_items)
            end
          else
            render_menu_items(menu_items)
          end
        end
      end

      def render_menu_items(menu_items)
        content_tag(list_tag, class: self.list_css) do
          menu_items.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, index)|
            buffer << render_menu_item(item, index, menu_items.length)
          end
        end
      end

      def render_menu_item(menu_item, index, menu_items_length)
        content_tag(list_item_tag, class: menu_item_css(menu_item[0], index, menu_items_length)) do
          buffer = ActiveSupport::SafeBuffer.new
          buffer << link_to(menu_item[0].menu_title, "#{menu_item[0].materialized_path}")
          buffer << render_list_wrapper(menu_item[1])
          buffer
        end
      end

      def menu_item_css(menu_item, index, menu_items_length)
        css = []
        css << list_item_css
        css << selected_css if (@selected_menu_items.present? && @selected_menu_items.include?(menu_item) )
        css << current_css if @current_menu_item == menu_item
        css << first_css if index == 0
        css << last_css if index + 1 == menu_items_length

        css.reject(&:blank?).presence
      end

    end
  end
end