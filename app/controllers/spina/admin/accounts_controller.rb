module Spina
  module Admin
    class AccountsController < AdminController
      before_action :set_locale

      def edit
        add_breadcrumb I18n.t('spina.preferences.account'), spina.edit_admin_account_path
      end

      def update
        current_account.update(account_params)
        redirect_back fallback_location: spina.edit_admin_account_path
      end

      def analytics
        add_breadcrumb I18n.t('spina.preferences.analytics'), spina.analytics_admin_account_path
      end

      def social
        add_breadcrumb I18n.t('spina.preferences.social_media'), spina.social_admin_account_path
      end

      def style
        add_breadcrumb I18n.t('spina.preferences.style'), spina.style_admin_account_path
        @themes = ::Spina::Theme.all
      end

      private

        def account_params
          params.require(:account).permit!
        end

        def set_locale
          @locale = params[:locale] || I18n.default_locale
        end
        
    end
  end
end
