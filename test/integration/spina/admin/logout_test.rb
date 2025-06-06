require "test_helper"

module Spina
  module Admin
    class LogoutTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
        post "/admin/sessions", params: {email: @user.email, password: @user.password}
      end

      test "logout and redirect to homepage" do
        get "/admin/logout"
        follow_redirect!
        assert_equal "/", path
      end
    end
  end
end
