require 'test_helper'

module Spina
  module Admin
    class LoginTest < ActionDispatch::IntegrationTest
      setup do
        @routes = Engine.routes
        FactoryBot.create :account
        @user = FactoryBot.create :user
      end

      test "login and browse pages" do
        get "/admin/login"
        assert_response :success

        post "/admin/sessions", params: {email: @user.email, password: "password"}
        follow_redirect!
        assert_equal '/admin', path

        get "/admin/pages"
        assert_response :success
        assert assigns(:pages)
      end

      test "login with wrong password" do
        get "/admin/login"
        assert_response :success
        post "/admin/sessions", params: {email: @user.email, password: "wrongpassword"}
        assert_equal '/admin/sessions', path
        assert_nil assigns(:pages)
      end
    end
  end
end
