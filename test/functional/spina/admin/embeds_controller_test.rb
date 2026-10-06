require "test_helper"

module Spina::Embeds
  class Attributeless < Base
    def to_trix_partial_path 
      nil
    end
    def to_trix_attachment 
      "<div>Attributeless embed</div>"
    end
  end
end

module Spina
  module Admin
    class EmbedsControllerTest < ActionController::TestCase
      setup do
        @routes = Spina::Engine.routes
        @account = FactoryBot.create(:account)
        @user = FactoryBot.create(:user)
        @controller.stubs(:current_spina_user).returns(@user)
      end

      test "should work with normal nested embeddable params" do
        post :create, params: {
          embed_type: "Spina::Embeds::Youtube",
          embeddable: {
            url: "https://www.youtube.com/watch?v=dQw4w9wgxcq"
          }
        }, format: :turbo_stream

        assert_response :success
      end

      test "should create embeddable with no attributes" do
        post :create, params: {
          embed_type: "Spina::Embeds::Attributeless"
        }, format: :turbo_stream

        assert_response :success
      end
    end
  end
end