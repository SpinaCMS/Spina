# require 'active_support/core_ext/string'
require 'active_support/configurable'
require 'action_view/helpers/tag_helper'
require 'action_view/helpers/url_helper'

module Spina
  module Pages
    class Breadcrumb
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::UrlHelper
      include ActiveSupport::Configurable

      config_accessor :list_tag, :list_class, :li, :list_wrapper, :list_item_tag, :list_item_css, :last_item_css

      self.list_tag = :ul
      self.list_class = 'breadcrumb'
      self.list_item_tag = :li
      self.list_item_css = nil
      self.last_item_css = 'active'
      self.list_wrapper = false

      attr_accessor :context, :current_page, :include_homepage, :breadcrumb_items, :homepage
      delegate :output_buffer, :output_buffer=, to: :context

      def initialize(page, context, include_homepage = true)
        @current_page = page
        @include_homepage = include_homepage
        @context = context
        @breadcrumb_items = Array.new()
        @homepage = Page.find_by(name: :homepage)

        build_breadcrumb(page) unless @homepage.id == @current_page.id
      end

      def to_html
        render_breadcrumb_wrapper(@breadcrumb_items)
      end

      private

      def build_breadcrumb(page)
        if !page.nil?
          @breadcrumb_items.push(page)

          build_breadcrumb(page.parent)
        else
          # Manually insert homepage and reverse the breadcrumb items once you hit the latest parent
          @breadcrumb_items.push(homepage) if @include_homepage
          @breadcrumb_items = @breadcrumb_items.reverse unless @breadcrumb_items.empty?
        end
      end

      def render_breadcrumb_wrapper(items)
        if items.any?
          if list_wrapper
            content_tag(:div) do
              render_breadcrumb_items(items)
            end
          else
            render_breadcrumb_items(items)
          end
        end
      end

      def render_breadcrumb_items(items)
        content_tag(list_tag, class: breadcrumb_list_css) do
          items.each_with_index.inject(ActiveSupport::SafeBuffer.new) do |buffer, (item, index)|
            buffer << render_breadcrumb_item(item, index, items.length)
          end
        end
      end

      def render_breadcrumb_item(item, index, items_length)
        content_tag(list_item_tag, class: breadcrumb_item_css(item, index, items_length)) do
          buffer = ActiveSupport::SafeBuffer.new
          if index + 1 == items_length
            buffer << item.title
          else
            buffer << link_to(item.title, item.full_materialized_path)
          end
          buffer
        end
      end

      def breadcrumb_list_css
        css = []
        css << list_class

        css.reject(&:blank?).presence
      end

      def breadcrumb_item_css(item, index, items_length)
        css = []
        css << list_item_css
        css << last_item_css if index + 1 == items_length

        css.reject(&:blank?).presence
      end

    end
  end
end
