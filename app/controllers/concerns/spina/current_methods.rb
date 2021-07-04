module Spina
  module CurrentMethods
    extend ActiveSupport::Concern
    
    included do
      before_action :set_current_attributes
    
      helper_method :current_theme
      helper_method :current_account
    end
  
    private
    
      def set_current_attributes
        current_theme
        current_account
      end
    
      def current_theme
        Spina::Current.theme ||= ::Spina::Theme.find_by_name(current_account.theme)
      end
    
      def current_account
        Spina::Current.account ||= ::Spina::Account.first
      end
        
  end
end
