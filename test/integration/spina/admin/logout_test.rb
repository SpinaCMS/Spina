require 'test_helper'

module Spina
  module Admin
    class LogoutTest < ActionDispatch::IntegrationTest
      setup do
        @routes = Engine.routes
        @user = FactoryGirl.create :user
        post "/admin/sessions", params: {email: @user.email, password: "password"}
      end

      test "logout and redirect to homepage" do
        get "/admin/logout"
        follow_redirect!
        assert_equal '/', path
      end
    end
  end
end
