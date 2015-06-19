module Spina
  class PagesController < ApplicationController
    before_action :current_user_can_view_page?, except: [:robots]

    def homepage
      render_with_template(page)
    end

    def show
      if should_skip_to_first_child?
        if page.is_root?
          redirect_to spina.subpage_path(page, first_live_child) and return
        else
          redirect_to spina.third_level_page_path(page.parent, page, first_live_child) and return
        end
      elsif page.link_url.present?
        redirect_to page.link_url and return
      end

      render_with_template(page)
    end

    private

      def page
        @page ||= (action_name == 'homepage') ? Page.find_by(name: 'homepage') : Page.find(params[:id])
      end
      helper_method :page

      def current_user_can_view_page?
        raise ActiveRecord::RecordNotFound unless page.live? || current_user.present?
      end

      def should_skip_to_first_child?
        page.skip_to_first_child && first_live_child
      end

      def first_live_child
        page.children.sorted.live.first
      end

      def render_with_template(page)
        render layout: "#{current_theme.to_s.parameterize.underscore}/application", template: "#{current_theme.to_s.parameterize.underscore}/pages/#{page.view_template || 'show'}"
      end

  end
end
