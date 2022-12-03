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

        @default_params = { page: { title: 'A new page', themes: { 'demo' => '1' } } }
      end

      test "new page form" do
        get "/admin/pages/new"
        assert_select 'form', action: "/admin/pages"
      end

      test "create new page" do
        post "/admin/pages", params: @default_params
        follow_redirect!
        assert_select 'div', text: /.*A\snew\spage.*/
      end

      test "create new page without title" do
        @default_params[:page][:title] = nil

        post "/admin/pages", params: @default_params
        assert_select '.field_with_errors'
      end

      test "create concept page" do
        @default_params[:page][:draft] = true

        post "/admin/pages", params: @default_params
        follow_redirect!
        assert_select 'div', text: /.*A\snew\spage.*/
        get "/admin/pages"
        assert_select 'small', text: "(draft)"
      end

      test "publish a page" do
        @page = FactoryBot.create :page, draft: true, title: "A page about dogs"
        get "/admin/pages/#{@page.id}/edit"
        assert_select 'span', text: "(Draft)"
        patch "/admin/pages/#{@page.id}", params: { page: { draft: false, themes: { 'demo' => '1' } } }
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
        assert_equal @page.parent.id, @homepage.id
      end

      test "change a view template" do
        @page = FactoryBot.create :page, title: "A page with a template", view_template: "show"
        get "/admin/pages/#{@page.id}/edit_template"
        assert_select "button[type='submit']", text: "Change view template"

        patch "/admin/pages/#{@page.id}", params: { page: {view_template: 'demo', themes: { 'demo' => '1' } } }

        @page.reload
        assert_equal 'demo', @page.view_template
      end

      test "delete a page" do
        page = FactoryBot.create(:page, title: "Test")
        delete "/admin/pages/#{page.id}"
        assert_redirected_to "/admin/pages"
      end

      test "delete a page with a resource" do
        resource = FactoryBot.create(:resource, name: "Test Resource")
        page = FactoryBot.create(:page, title: "Test Page", resource_id: resource.id)
        delete "/admin/pages/#{page.id}"
        assert_redirected_to "/admin/pages?resource_id=#{resource.id}"
      end
    end
  end
end
