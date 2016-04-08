module Spina
  module Admin
    class AdminController < ApplicationController
      before_action :set_admin_locale
      before_action :authorize_user
      before_action :new_messages

      layout 'spina/admin/application'

      def current_admin_path
        request.fullpath[%r{/#{ Spina.config.backend_path }(.*)}, 1]
      end
      helper_method :current_admin_path

      private

      def set_admin_locale
        I18n.locale = I18n.default_locale
      end

      def authorize_user
        redirect_to spina.admin_login_url, flash: {information: I18n.t('spina.notifications.login')} unless current_user
      end

      def new_messages
        @new_messages = Inquiry.new_messages.sorted
      end

    end
  end
end
