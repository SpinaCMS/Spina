require 'test_helper'

module Spina
  module Admin
    class AccountsTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
        post "/admin/sessions", params: {email: @user.email, password: "password"}
      end

      test "Show form with general settings" do
        get "/admin/account/edit"
        assert_select 'form #account_name'
      end

      test "Update account name" do
        name = "Demo Spina website"
        patch "/admin/account", params: {account: {name: name}}
        @account.reload
        assert_equal name, @account.name
      end

      test "Show form with theme config" do
        get "/admin/account/style"
        assert_select 'form select#account_theme'
      end

      test "Show form with settings for analytics" do
        get "/admin/account/analytics"
        assert_select 'form #account_robots_allowed'
      end

      test "Show form with social media accounts" do
        get "/admin/account/social"
        assert_select 'form #account_facebook'
      end

    end
  end
end
