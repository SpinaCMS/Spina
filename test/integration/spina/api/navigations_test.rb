require 'test_helper'

module Spina
  module Api
    class NavigationsTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @navigation = FactoryBot.create :navigation
        @page = FactoryBot.create :homepage
        FactoryBot.create :navigation_item, page: @page, navigation: @navigation
      end

      test "get all navigations" do
        get "/api/navigations.json", headers: {'Authorization' => 'Token dummy_api_key'}
        assert_not_empty @response.parsed_body.dig("data")
      end
      
      test "show navigation" do
        get "/api/navigations/#{@navigation.id}.json", headers: {'Authorization' => 'Token dummy_api_key'}
        assert_not_nil @response.parsed_body.dig("data", "attributes", "tree")
      end

    end
  end
end
