require 'test_helper'

module Spina
  module Admin
    class UsersTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
        post "/admin/sessions", params: {email: @user.email, password: "password"}
      end

      test "new user form" do
        get "/admin/users/new"
        assert_select '#new_user'
      end

      test "create new user" do
        post "/admin/users", params: {user: {name: "Joe", email: "joe@denkgroot.com", password: "test"}}
        follow_redirect!
        assert_select 'div', text: /Joe/
      end

      test "create new user without password" do
        post "/admin/users", params: {user: {name: "Joe", email: "joe@denkgroot.com"}}
        assert_select '.field_with_errors'
      end

      test "update user" do
        patch "/admin/users/#{@user.id}", params: {user: {name: "New name"}}
        get "/admin/users"
        assert_select 'div', text: /New name/
      end

    end
  end
end
