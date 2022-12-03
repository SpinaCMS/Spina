module Spina
  module Frontend
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound, with: :redirect_or_render_404

      helper Spina::PagesHelper
      
      before_action :set_locale
      before_action :set_current_page
      before_action :set_current_spina_account
    end

    def show
      if should_skip_to_first_child?
        redirect_to first_live_child.try(:materialized_path) and return
      elsif page.link_url.present?
        redirect_to Spina::Current.page.link_url and return
      end

      render_with_template(page)
    end

    private

      def set_locale
        I18n.locale = params[:locale] || I18n.default_locale
      end

      # ADDITION
      # rescue from page.nil?
      def set_current_page
        raise ActiveRecord::RecordNotFound unless page.present?

        Spina::Current.page = page
        Spina::Current.page.view_context = view_context
      end

      def set_current_spina_account
        Spina::Current.account = Spina::Account.first
        Spina::Current.account.view_context = view_context
      end

      # DEPRECIATE!
      # in favor of reconfigured #page
      # def page_by_locale(locale)
      #   I18n.with_locale(locale) do
      #     Page.i18n.find_by!(materialized_path: spina_request_path)
      #   end
      # end

      # REFACTOR
      # complexity moved to Spina::Page#find_by_path_locale_and_theme
      def page
        theme_name = Spina::Current.account.theme

        @page =
          Spina::Page.find_by_path_locale_and_theme(
            locale: set_locale,
            theme_name:,
            path: spina_request_path
          )
      end

      def spina_request_path
        segments = [Spina.mounted_at, params[:locale], params[:id]].compact
        File.join(*segments)
      end

      def should_skip_to_first_child?
        Spina::Current.page.skip_to_first_child && first_live_child
      end

      def first_live_child
        Spina::Current.page.children.sorted.live.first
      end

      def redirect_or_render_404
        if rule = RewriteRule.find_by(old_path: spina_request_path)
          redirect_to rule.new_path, status: :moved_permanently
        else
          render_404
        end
      end

      def render_404
        render file: "#{Rails.root}/public/404.html", status: 404, layout: false
      end

      def render_with_template(page)
        render layout: "#{current_theme.name.parameterize.underscore}/#{page.layout_template || 'application'}", template: "#{current_theme.name.parameterize.underscore}/pages/#{Spina::Current.page.view_template || 'show'}"
      end

  end
end
