require 'test_helper'

module Spina
  module Admin
    class PagesTest < ActionDispatch::IntegrationTest
      setup do
        @routes = Engine.routes
        post_via_redirect "/admin/sessions", email: spina_users(:bram).email, password: "password"
      end

      test "new page form" do
        get "/admin/pages/new"
        assert_select '#new_page'
      end

      test "create new page" do
        post_via_redirect "/admin/pages", page: {title: "A new page"}
        assert_select '.breadcrumbs', text: /A\snew\spage\z/
      end

      test "create new page without title" do
        post_via_redirect "/admin/pages", page: {title: nil}
        assert_select '#error_explanation'
      end

      test "create concept page" do
        post_via_redirect "/admin/pages", page: {title: "A new page", draft: true}
        assert_select '.breadcrumbs', text: /A\snew\spage\z/
        get "/admin/pages"
        assert_select '.dd-item-inner small', text: '(draft)'
      end
    end
  end
end