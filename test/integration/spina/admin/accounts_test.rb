require "test_helper"

module Spina
  module Admin
    class AccountsTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
        post "/admin/sessions", params: {email: @user.email, password: @user.password}
      end

      test "Show form with general settings" do
        get "/admin/account/edit"
        assert_select "form #account_name"
      end

      test "Update account name" do
        name = "Demo Spina website"
        patch "/admin/account", params: {account: {name: name}}
        @account.reload
        assert_equal name, @account.name
      end

      test "Show form with theme config" do
        get "/admin/theme/edit"
        assert_select "form select#account_theme"
      end

      test "Show form with layout parts" do
        get "/admin/layout/edit"
        assert_select 'form input[type="text"]'
      end

      test "Update layout parts" do
        patch "/admin/layout", params: {account: {name: "Demo Spina website"}}
        follow_redirect!
        assert_select "turbo-frame#flash div", text: "Layout saved"
      end
    end
  end
end
