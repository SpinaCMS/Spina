require 'test_helper'

module Spina
  module Admin
    class PagesTest < ActionDispatch::IntegrationTest
      setup do
        @routes = Engine.routes
      end

      test "login and browse pages" do
        get "/admin/login"
        assert_response :success

        post_via_redirect "/admin/sessions", email: spina_users(:bram).email, password: "password"
        assert_equal '/admin', path

        get "/admin/pages"
        assert_response :success
        assert assigns(:pages)
      end
    end
  end
end