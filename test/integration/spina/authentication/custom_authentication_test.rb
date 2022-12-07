require "test_helper"

module SuperCustomApp
  module Authentication
    extend ActiveSupport::Concern

    included do
      helper_method :current_custom_user
      helper_method :logged_in?
      helper_method :logout_path
    end

    def current_custom_user
      cookies[:custom_user_id]
    end

    def logged_in?
      current_custom_user
    end

    def logout_path
      "/super/custom/logout"
    end

    private

    def authenticate
      redirect_to "/super/custom/login" unless logged_in?
    end
  end
end

module Spina
  module Authentication
    class CustomAuthenticationTest < ActionDispatch::IntegrationTest
      include AuthenticationHelper

      setup do
        host! "dummy.test"

        change_authentication("SuperCustomApp::Authentication")

        @routes = Engine.routes
        @account = FactoryBot.create :account
      end

      teardown do
        change_authentication("Spina::Authentication::Sessions")
      end

      test "visiting admin without logging in" do
        get spina.admin_root_url
        assert_redirected_to "/super/custom/login"
      end

      test "visiting admin when logged in" do
        cookies[:custom_user_id] = 1
        get spina.admin_root_url
        assert_response :ok
      end
    end
  end
end
