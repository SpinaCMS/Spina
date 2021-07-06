module Spina
  module CurrentTheme
    extend ActiveSupport::Concern
    
    included do
      helper_method :current_theme
    end
  
    private
    
      def current_theme
        Spina::Current.theme ||= ::Spina::Theme.find_by_name(current_account.theme)
      end
        
  end
end
