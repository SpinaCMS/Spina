module Spina
  class UserMailerPreview < ActionMailer::Preview
    
    def forgot_password
      UserMailer.forgot_password(Spina::User.first, "macOS", "Safari", format: :txt)
    end
    
  end
end