module Spina
  module CurrentAccount
    extend ActiveSupport::Concern
    
    included do
      helper_method :current_account
    end
  
    private
    
      def current_account
        Spina::Current.account ||= ::Spina::Account.first
      end
        
  end
end
