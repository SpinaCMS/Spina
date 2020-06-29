require 'test_helper'

module Spina
  module Admin
    class NavigationsTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
        @navigation = FactoryBot.create :navigation
        post "/admin/sessions", params: {email: @user.email, password: "password"}
      end

      test "List navigations" do
        get("/admin/pages")
        assert_select 'nav.tabs li a', 'Custom nav'
      end

      test "Show navigation" do
        get("/admin/navigations/#{@navigation.id}")
        assert_select 'nav.tabs li.active a', 'Custom nav'
      end

      test "Edit a navigation with pages to select" do
        get("/admin/navigations/#{@navigation.id}/edit")
        assert_select 'input[type="checkbox"][name="navigation[page_ids][]"]'
      end

    end
  end
end
