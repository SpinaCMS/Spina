require 'test_helper'

module Spina
  module Api
    class NavigationsTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        FactoryBot.reload
        @routes = Engine.routes
        @account = FactoryBot.create :account
        @page = FactoryBot.create :page, title: "A page"
        @navigation = FactoryBot.create(:navigation) do |navigation|
          FactoryBot.create_list(:navigation_item, 1, navigation: navigation, page: @page)
        end
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
