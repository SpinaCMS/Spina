require "test_helper"

module Spina
  module Admin
    class EmbedsControllerTest < ActionController::TestCase
      setup do
        @routes = Spina::Engine.routes
        @account = FactoryBot.create(:account)
        @user = FactoryBot.create(:user)
        sign_in @user
      end

      test "should work with normal nested embeddable params" do
        post :create, params: {
          embed_type: "Spina::Embeds::YouTube",
          embeddable: {
            url: "https://www.youtube.com/watch?v=dQw4w9wgxcq"
          }
        }, format: :turbo_stream

        assert_response :success
      end

      test "should create embeddable with no attributes (no embeddable param sent)" do
        post :create, params: {
          embed_type: "Spina::Embeds::YouTube"
        }, format: :turbo_stream

        assert_response :success
      end
    end
  end
end