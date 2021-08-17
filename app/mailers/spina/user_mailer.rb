module Spina
  class UserMailer < ActionMailer::Base
    layout 'spina/mail'

    def forgot_password(user, os, browser)
      @user = user
      @os = os
      @browser = browser

      mail(
        to: @user.email, 
        from: current_account.email, 
        subject: t('spina.forgot_password.mail_subject')
      )
    end

    private

      def current_account
        Spina::Account.first
      end
  end
end