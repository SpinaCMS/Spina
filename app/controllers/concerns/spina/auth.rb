module Spina
  module Auth
    extend ActiveSupport::Concern
    
    included do
      helper_method :authorize
    end
    
    def authenticate
      redirect_to admin_login_path, flash: {information: I18n.t('spina.notifications.login')} unless authenticated?
    end
    
    def authenticated?
      current_spina_user
    end
    
    def authorize(object)
      true
    end
    
    private
    
      def current_spina_user
        Spina::Current.user ||= User.find_by(id: session[:spina_user_id]) if session[:spina_user_id]
      end
  
  end
end