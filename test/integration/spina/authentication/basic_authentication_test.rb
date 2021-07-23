require 'test_helper'

module Spina
  module Authentication
    class BasicAuthenticationTest < ActionDispatch::IntegrationTest
      include AuthenticationHelper
      
      setup do
        host! "dummy.test"
        
        change_authentication("Spina::Authentication::Basic")

        @routes = Engine.routes
        @account = FactoryBot.create :account
      end
      
      teardown do
        change_authentication("Spina::Authentication::Sessions")
      end
      
      test "visiting admin without logging in" do
        get spina.admin_root_url
        assert_response :unauthorized
      end
      
      test "logging in using HTTP Basic authentication" do
        get spina.admin_root_url, headers: {Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(Rails.application.credentials.spina[:username], Rails.application.credentials.spina[:password]) }
        assert_response :ok
      end

    end
  end
end
