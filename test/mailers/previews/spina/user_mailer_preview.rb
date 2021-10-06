module Spina
  class UserMailerPreview < ActionMailer::Preview
    
    def forgot_password
      UserMailer.forgot_password(Spina::User.first, "Mozilla/5.0 (iPhone; CPU iPhone OS 11_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1")
    end
    
  end
end