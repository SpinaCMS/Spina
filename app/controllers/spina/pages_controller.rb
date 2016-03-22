module Spina
  class PagesController < Spina::ApplicationController
    before_action :rewrite_page, only: [:show]
    before_action :current_user_can_view_page?, except: [:robots]
    before_action :set_locale

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
        @page ||= (action_name == 'homepage') ? Page.find_by!(name: 'homepage') : Page.find_by!(materialized_path: "/" + params[:id])
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
