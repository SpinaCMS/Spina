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
      end
      
      test "homepage exists in api/pages" do
        get "/api/pages.json", headers: {'Authorization' => 'Token dummy_api_key'}
        assert_includes @response.parsed_body.dig("data").map{|data| data.dig("attributes", "name")}, "homepage"
      end

    end
  end
end
