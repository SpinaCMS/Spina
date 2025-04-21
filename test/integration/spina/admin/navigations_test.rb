require "test_helper"

module Spina
  module Admin
    class NavigationsTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
        @navigation = FactoryBot.create :navigation
        post "/admin/sessions", params: {email: @user.email, password: @user.password}
      end

      test "Edit a navigation with pages to select" do
        get("/admin/navigations/#{@navigation.id}/edit")
        assert_select "a div", "Add menu item"
      end

      test "Add a menu item" do
        @page = FactoryBot.create :homepage

        get "/admin/navigations/#{@navigation.id}/navigation_items/new"
        assert_select 'button[type="submit"]', text: "Add menu item"

        post "/admin/navigations/#{@navigation.id}/navigation_items", params: {navigation_item: {page_id: @page.id}}

        get "/admin/navigations/#{@navigation.id}/edit"

        assert_select "div", text: "Homepage"
      end
    end
  end
end
