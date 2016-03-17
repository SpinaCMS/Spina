module Spina
  module Admin
    class AdminController < ApplicationController

      before_action :authorize_user
      before_action :new_messages

      layout 'spina/admin/application'

      private

      def authorize_user
        redirect_to spina.admin_login_url, flash: {information: I18n.t('spina.notifications.login')} unless current_user
      end

      def new_messages
        @new_messages = Inquiry.new_messages.sorted
      end

    end
  end
end
