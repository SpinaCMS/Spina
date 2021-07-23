require 'test_helper'

module Spina
  module Admin
    class PagesTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
        post "/admin/sessions", params: {email: @user.email, password: "password"}
      end

      test "new page form" do
        get "/admin/pages/new"
        assert_select 'form', action: "/admin/pages"
      end

      test "create new page" do
        post "/admin/pages", params: {page: {title: "A new page"}}
        follow_redirect!
        assert_select 'div', text: /.*A\snew\spage.*/
      end

      test "create new page without title" do
        post "/admin/pages", params: {page: {title: nil}}
        assert_select '.field_with_errors'
      end

      test "create concept page" do
        post "/admin/pages", params: {page: {title: "A new page", draft: true}}
        follow_redirect!
        assert_select 'div', text: /.*A\snew\spage.*/
        get "/admin/pages"
        assert_select 'small', text: "(draft)"
      end
      
      test "publish a page" do
        @page = FactoryBot.create :page, draft: true, title: "A page about dogs"
        get "/admin/pages/#{@page.id}/edit"
        assert_select 'span', text: "(Draft)"
        patch "/admin/pages/#{@page.id}", params: {page: {draft: false}}
        follow_redirect!
        assert_select 'small', {count: 0, text: "(Draft)"}
      end
      
      test "move a page" do
        @homepage = FactoryBot.create :homepage
        @page = FactoryBot.create :page, title: "A page about dogs"
        get "/admin/pages/#{@page.id}/move/new"
        assert_select "button[type='submit']", text: "Move page"
        
        patch "/admin/pages/#{@page.id}/move", params: {page: {parent_id: @homepage.id}}
        @page.reload
        assert_equal @page.parent, @homepage
      end
      
      test "change a view template" do
        @page = FactoryBot.create :page, title: "A page with a template", view_template: "show"
        get "/admin/pages/#{@page.id}/edit_template"
        assert_select "button[type='submit']", text: "Change view template"
        
        patch "/admin/pages/#{@page.id}", params: {page: {view_template: "demo"}}
        @page.reload
        assert_equal @page.view_template, "demo"
      end
    end
  end
end
