module Spina
  class ApplicationMailer < ActionMailer::Base
    default Spina.config.mailer_defaults
    
    layout 'spina/mail'
  end
end
