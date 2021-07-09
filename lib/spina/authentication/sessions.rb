module Spina
  module Authentication
    module Sessions
      extend ActiveSupport::Concern
      
      included do
        helper_method :current_spina_user
        helper_method :logged_in?
        helper_method :logout_path
      end
      
      def current_spina_user
        Spina::Current.user ||= User.find_by(id: session[:spina_user_id]) if session[:spina_user_id]
      end
      
      def logged_in?
        current_spina_user
      end
      
      def logout_path
        spina.admin_logout_path
      end
      
      private
      
        def authenticate
          redirect_to admin_login_path, flash: {information: I18n.t('spina.notifications.login')} unless logged_in?
        end
    
    end
  end
end