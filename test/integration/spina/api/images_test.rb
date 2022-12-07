require "test_helper"

module Spina
  module Api
    class ImagesTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account

        spina_png = fixture_file_upload("spina.png", "image/png")
        @image = Spina::Image.create(file: spina_png)
      end

      test "show image" do
        get "/api/images/#{@image.id}.json", headers: {"Authorization" => "Token dummy_api_key"}
        assert_not_empty @response.parsed_body.dig("data", "attributes", "original_url")
        assert_not_empty @response.parsed_body.dig("data", "attributes", "thumbnail_url")
        assert_not_empty @response.parsed_body.dig("data", "attributes", "embedded_image_size_url")
      end
    end
  end
end
