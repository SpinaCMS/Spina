module Spina
  module Api
    class ApiController < ActionController::Base
      protect_from_forgery unless: -> { request.format.json? }
      
      rescue_from ActiveRecord::RecordNotFound, with: :render_404
      
      TOKEN = Spina::Pro.config.api_key
      
      before_action -> { current_account && current_theme }
      before_action :authenticate_api
      
      def current_account
        Spina::Current.account ||= Account.first
      end
      
      def current_theme
        Spina::Current.theme ||= Theme.find_by_name(current_account.theme)
      end
      
      private
      
        def render_404
          render json: {error: "Not Found"}, status: :not_found
        end

        def authenticate_api
          head :not_found and return if TOKEN.blank?
          authenticate_or_request_with_http_token do |token, options|
            ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
          end
        end
      
    end
  end
end