module Spina
  module CurrentSpinaAccount
    extend ActiveSupport::Concern
    
    included do
      before_action :current_spina_account
      helper_method :current_spina_account
    end
  
    private
    
      def current_spina_account
        Spina::Current.account ||= ::Spina::Account.first
      end
        
  end
end
