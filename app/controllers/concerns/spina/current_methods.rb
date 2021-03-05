module Spina
  module CurrentMethods
    extend ActiveSupport::Concern
    
    included do
      helper_method :current_theme
      helper_method :current_spina_user
      helper_method :current_account
    end
  
    private
    
      def current_theme
        @current_theme ||= Spina::Theme.find_by_name(current_account.theme)
      end
      
      def current_spina_user
        @current_spina_user ||= Spina::User.where(id: session[:user_id]).first if session[:user_id]
      end
    
      def current_account
        @current_account ||= Spina::Account.first
      end
        
  end
end
