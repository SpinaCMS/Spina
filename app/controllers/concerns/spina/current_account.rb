module Spina
  module CurrentAccount
    extend ActiveSupport::Concern
    
    included do
      before_action :current_account
      helper_method :current_account
    end
  
    private
    
      def current_account
        Spina::Current.account ||= ::Spina::Account.first
      end
        
  end
end
