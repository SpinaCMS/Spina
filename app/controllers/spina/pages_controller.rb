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
        unless page.present?
          @rule = RewriteRule.find_by(old_path: "/" + params[:id])
          redirect_to @rule.new_path, status: :moved_permanently if @rule.present?
        end
      end

      def page
        @page ||= (action_name == 'homepage') ? Page.find_by!(name: 'homepage') : Page.with_translations(I18n.locale).find_by!(materialized_path: materialized_path) || Page.with_translations(I18n.default_locale).find_by!(materialized_path: request.path)
      end
      helper_method :page

      def materialized_path
        segments = ['/', params[:locale], params[:id]].compact
        File.join(*segments)
      end

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
        render layout: "#{current_theme.name.parameterize.underscore}/application", template: "#{current_theme.name.parameterize.underscore}/pages/#{page.view_template || 'show'}"
      end

      def render_404
        render file: "#{Rails.root}/public/404.html", status: 404
      end

  end
end
