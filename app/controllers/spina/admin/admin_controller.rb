module Spina
  module Admin
    class AdminController < ApplicationController
      before_action :set_admin_locale
      before_action :authorize_user
      before_action :new_messages

      layout 'spina/admin/application'

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

      def current_account
        @current_account ||= Account.first
      end
      helper_method :current_account

      def current_user
        @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
      end
      helper_method :current_user

      def current_ability
        @current_ability ||= Ability.new(current_user)
      end

    end
  end
end
