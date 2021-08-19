module Spina
  class UserMailer < ApplicationMailer

    def forgot_password(user, user_agent_string = nil)
      @user = user
      @browser = Browser.new(user_agent_string)
      
      mail to: @user.email, 
           subject: t('spina.user_mailer.forgot_password.subject')
    end

  end
end