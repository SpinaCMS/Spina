require 'test_helper'

module Spina
  module Api
    class ResourcesTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @resource = FactoryBot.create :breweries
      end
      
      test "list resources" do
        get "/api/resources.json", headers: {'Authorization' => 'Token dummy_api_key'}
        assert_not_empty @response.parsed_body.dig("data")
        assert_not_empty @response.parsed_body.dig("meta")
      end
      
      test "show resource" do
        get "/api/resources/#{@resource.id}.json", headers: {'Authorization' => 'Token dummy_api_key'}
        assert_equal "breweries", @response.parsed_body.dig("data", "attributes", "name")
        assert_nil @response.parsed_body.dig("relationships", "pages")
        assert_equal "/api/resources/#{@resource.id}/pages", @response.parsed_body.dig("data", "relationships", "pages", "links", "related")
      end

    end
  end
end
