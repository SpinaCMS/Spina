module Spina
  module Authentication
    module Basic
      extend ActiveSupport::Concern
      
      included do
        helper_method :logged_in?
      end
      
      def logged_in?
        authenticate
      end
      
      private
      
        def authenticate
          authenticate_or_request_with_http_basic do |username, password|
            username == Rails.application.credentials.dig(:spina, :username) && password == Rails.application.credentials.dig(:spina, :password)
          end
        end
    
    end
  end
end