require 'test_helper'

module Spina
  module Admin
    class ResourcesTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
        @breweries = FactoryBot.create :breweries
        post "/admin/sessions", params: {email: @user.email, password: "password"}
      end

      test "list resources" do
        get "/admin/resources/#{@breweries.id}"
        assert_select '.breadcrumbs', text: /.*Breweries.*/
      end

      test "new resource page" do
        get "/admin/pages/new?resource_id=#{@breweries.id}"
        assert_select "#page_resource_id option[value='#{@breweries.id}'][selected='selected']"
      end

      test "create new resource page" do
        post "/admin/pages", params: {page: {title: "Brewery", resource_id: @breweries.id}}
        follow_redirect!
        assert_select '.breadcrumbs', text: /.*Brewery.*/
        assert_select '.breadcrumbs', text: /\ABreweries/
      end

      test "edit resource" do
        get "/admin/resources/#{@breweries.id}/edit"
        assert_select '.breadcrumbs', text: /.*Edit.*/
      end

      test "update resource" do
        put "/admin/resources/#{@breweries.id}", params: {resource: {label: "Top Breweries"}}
        follow_redirect!
        assert_select '.breadcrumbs', text: /.*Top\sBreweries.*/
      end

    end
  end
end
