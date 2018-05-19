module Spina
  module Admin
    class AdminController < ::Spina::ApplicationController
      before_action :set_admin_locale
      before_action :authorize_spina_user

      def current_admin_path
        request.fullpath[%r{/#{ Spina.config.backend_path }(.*)}, 1]
      end
      helper_method :current_admin_path

      private

      def set_admin_locale
        I18n.locale = I18n.default_locale
      end

      def authorize_spina_user
        redirect_to admin_login_path, flash: {information: I18n.t('spina.notifications.login')} unless current_spina_user
      end

      def authorize_admin
        render status: 401 unless current_spina_user.admin?
      end

    end
  end
end
