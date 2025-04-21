require "test_helper"

module Spina
  module Authentication
    class SessionAuthenticationTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
      end

      test "visiting admin without logging in" do
        get spina.admin_root_url
        assert_redirected_to spina.admin_login_path
      end

      test "login" do
        post "/admin/sessions", params: {email: @user.email, password: @user.password}
        assert_redirected_to spina.admin_root_url
      end
    end
  end
end
