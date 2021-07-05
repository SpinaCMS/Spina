module Spina
  module BasicAuthentication
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
          "spina" == username && "demo" == password
        end
      end
  
  end
end