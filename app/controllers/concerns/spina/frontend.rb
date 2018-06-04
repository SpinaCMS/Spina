module Spina
  module Frontend
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound, with: :redirect_or_render_404
      
      before_action :set_locale
      before_action :set_current_page
    end

    def show
      if should_skip_to_first_child?
        redirect_to first_live_child.try(:materialized_path) and return
      elsif page.link_url.present?
        redirect_to Current.page.link_url and return
      end

      render_with_template(page)
    end

    private

      def set_locale
        I18n.locale = params[:locale] || I18n.default_locale
      end

      def set_current_page
        Current.page = page
      end

      def page_by_locale(locale)
        I18n.with_locale(locale) do
          Page.i18n.find_by!(materialized_path: spina_request_path)
        end
      end

      def page
        @page = if action_name == 'homepage'
          Page.find_by!(name: 'homepage')
        else 
          page_by_locale(I18n.locale) || page_by_locale(I18n.default_locale)
        end
      end

      def spina_request_path
        segments = ['/', params[:locale], params[:id]].compact
        File.join(*segments)
      end

      def should_skip_to_first_child?
        Current.page.skip_to_first_child && first_live_child
      end

      def first_live_child
        Current.page.children.sorted.live.first
      end

      def redirect_or_render_404
        if rule = RewriteRule.find_by(old_path: spina_request_path)
          redirect_to rule.new_path, status: :moved_permanently
        else
          render_404
        end
      end

      def render_404
        render file: "#{Rails.root}/public/404.html", status: 404
      end

      def render_with_template(page)
        render layout: "#{current_theme.name.parameterize.underscore}/#{page.layout_template || 'application'}", template: "#{current_theme.name.parameterize.underscore}/pages/#{Current.page.view_template || 'show'}"
      end

  end
end