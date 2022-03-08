module Spina
  module CurrentTheme
    extend ActiveSupport::Concern
    
    included do
      before_action :current_theme
      helper_method :current_theme
    end
  
    private
    
      def current_theme
        Spina::Current.theme ||= ::Spina::Theme.find_by_name(current_spina_account.theme)
      end
        
  end
end
