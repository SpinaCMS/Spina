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

test "Add a menu item with a URL" do
  post "/admin/navigations/#{@navigation.id}/navigation_items", params: {navigation_item: {kind: "url", url_title: "Spina", url: "https://www.spinacms.com"}}

  get "/admin/navigations/#{@navigation.id}/edit"

  assert_select "div", text: "Spina"
  assert_select "a[href='https://www.spinacms.com']"
end

test "Add a menu item with a javascript: URL is rejected" do
  assert_no_difference "Spina::NavigationItem.count" do
    post "/admin/navigations/#{@navigation.id}/navigation_items", params: {navigation_item: {kind: "url", url_title: "Important Update", url: "javascript:alert(document.cookie)"}}
  end

  assert_match "must be a relative path or start with http://, https://, mailto: or tel:", response.body

  get "/admin/navigations/#{@navigation.id}/edit"

  assert_select "a[href^='javascript:']", count: 0
end

test "Update a menu item with a javascript: URL is rejected" do
  navigation_item = @navigation.navigation_items.create!(kind: "url", url_title: "Spina", url: "https://www.spinacms.com")

  patch "/admin/navigations/#{@navigation.id}/navigation_items/#{navigation_item.id}", params: {navigation_item: {url: "javascript:alert(document.cookie)"}}

  assert_equal "https://www.spinacms.com", navigation_item.reload.url
end
    end
  end
end
