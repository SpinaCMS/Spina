module Spina
  class InquiryMailer < ActionMailer::Base
    layout 'spina/email'

    def inquiry(inquiry)
      @inquiry = inquiry
      @current_account = Account.first

      # attachments.inline['logo.jpg'] = LogoUploader.new.read(@current_account.logo) if @current_account.logo.url

      mail( 
        to: "\"#{@current_account.name}\" <#{ @current_account.email }>", 
        from: "\"#{@inquiry.name}\" <#{@inquiry.email}>",
        subject: @inquiry.message.truncate(97, separator: ' ')
      )
    end

  end
end
