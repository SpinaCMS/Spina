require 'test_helper'

module Spina
  module Api
    class PagesTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
      end

      test "get all pages" do
        get "/api/pages.json", headers: {'Authorization' => 'Token dummy_api_key'}
        assert_not_empty @response.parsed_body.dig("data")
        assert_not_empty @response.parsed_body.dig("meta")
      end
      
      test "homepage exists in api/pages" do
        get "/api/pages.json", headers: {'Authorization' => 'Token dummy_api_key'}
        assert_includes @response.parsed_body.dig("data").map{|data| data.dig("attributes", "name")}, "homepage"
      end
      
      test "get page details" do
        page = Spina::Page.first
        get "/api/pages/#{page.id}.json", headers: {'Authorization' => 'Token dummy_api_key'}
        assert_not_empty @response.parsed_body.dig("data", "attributes", "content")
      end
      
      test "get page that does not exist" do
        get "/api/pages/#{Spina::Page.maximum(:id) + 1}.json", headers: {'Authorization' => 'Token dummy_api_key'}
        assert_response :not_found
        assert_equal "Not Found", @response.parsed_body.dig("error")
      end

    end
  end
end
