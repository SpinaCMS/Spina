require 'test_helper'

module Spina
  module Admin
    class ImagesTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
        post "/admin/sessions", params: {email: @user.email, password: "password"}
      end

      test "view all images with image upload form" do
        get "/admin/images"
        assert_select 'input#image_files[type="file"]'
      end

      test "upload a new image" do
        spina_png = fixture_file_upload('files/spina.png','image/png')
        post "/admin/images", params: {image: {files: [spina_png]}, format: :js}
        get "/admin/images"
        assert_select 'span.photo-name', 'spina.png'
      end

      test "delete image" do
        spina_png = fixture_file_upload('files/spina.png','image/png')
        post "/admin/images", params: {image: {files: [spina_png]}, format: :js}
        delete "/admin/images/#{Spina::Image.last.id}"
      end

    end
  end
end
