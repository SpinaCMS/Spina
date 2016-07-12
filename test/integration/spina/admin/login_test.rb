require 'test_helper'

module Spina
  module Admin
    class LoginTest < ActionDispatch::IntegrationTest
      setup do
        @routes = Engine.routes
      end

      test "login and browse pages" do
        get "/admin/login"
        assert_response :success

        post_via_redirect "/admin/sessions", email: spina_users(:bram).email, password: "password"
        assert_equal '/admin/pages', path

        get "/admin/pages"
        assert_response :success
        assert assigns(:pages)
      end

      test "login with wrong password" do
        get "/admin/login"
        assert_response :success
        post_via_redirect "/admin/sessions", email: spina_users(:bram).email, password: "wrongpassword"
        assert_equal '/admin/sessions', path
        assert_nil assigns(:pages)
      end
    end
  end
end