require 'test_helper'

module Spina
  module Admin
    class LogoutTest < ActionDispatch::IntegrationTest
      setup do
        @routes = Engine.routes
        post_via_redirect "/admin/sessions", email: spina_users(:bram).email, password: "password"
      end

      test "logout and redirect to homepage" do
        get_via_redirect "/admin/logout"
        assert_equal '/', path
      end
    end
  end
end