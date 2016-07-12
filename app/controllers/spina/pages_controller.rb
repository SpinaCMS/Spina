module Spina
  class PagesController < Spina::ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    before_action :set_locale
    before_action :rewrite_page, only: [:show]
    before_action :current_user_can_view_page?, except: [:robots]

    def homepage
      render_with_template(page)
    end

    def show
      if should_skip_to_first_child?
        redirect_to first_live_child.try(:materialized_path) and return
      elsif page.link_url.present?
        redirect_to page.link_url and return
      end

      render_with_template(page)
    end

    private

      def set_locale
        I18n.locale = params[:locale] || I18n.default_locale
      end

      def rewrite_page
        if page.nil? && rule = RewriteRule.find_by(old_path: "/" + params[:id])
          redirect_to rule.new_path, status: :moved_permanently
        end
      end

      def page_by_locale(locale)
        Page.with_translations(locale).find_by(materialized_path: spina_request_path)
      end

      def page
        current_page = page_by_locale(I18n.locale) || page_by_locale(I18n.default_locale)
        @page ||= (action_name == 'homepage') ? Page.find_by!(name: 'homepage') : current_page
      end
      helper_method :page

      def spina_request_path
        segments = ['/', params[:locale], params[:id]].compact
        File.join(*segments)
      end

      def current_user_can_view_page?
        raise ActiveRecord::RecordNotFound if page.nil? || !page.live?

        current_user.present?
      end

      def should_skip_to_first_child?
        page.skip_to_first_child && first_live_child
      end

      def first_live_child
        page.children.sorted.live.first
      end

      def render_with_template(page)
        render layout: "#{current_theme.name.parameterize.underscore}/#{page.layout_template || 'application'}", template: "#{current_theme.name.parameterize.underscore}/pages/#{page.view_template || 'show'}"
      end

      def render_404
        render file: "#{Rails.root}/public/404.html", status: 404
      end

  end
end
