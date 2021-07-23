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
        assert_select 'input#new_image_file_field[type="file"]'
      end

      test "upload a new image" do
        spina_png = fixture_file_upload('spina.png','image/png')
        post "/admin/images", params: {image: {files: [spina_png]}, format: :js}
        get "/admin/images"
        assert_select 'span', 'spina.png'
      end

      test "delete image" do
        spina_png = fixture_file_upload('spina.png','image/png')
        post "/admin/images", params: {image: {files: [spina_png]}, format: :js}
        delete "/admin/images/#{Spina::Image.last.id}"
      end
      
      test "move an image to a folder" do
        spina_png = fixture_file_upload('spina.png','image/png')
        post "/admin/images", params: {image: {files: [spina_png]}, format: :js}
        @media_folder = FactoryBot.create :media_folder, name: "Beautiful logos"
        get "/admin/images"
        assert_select "div", text: "Beautiful logos"
        assert_select 'span', 'spina.png'
        patch "/admin/images/#{Spina::Image.first.id}", params: {image: {media_folder_id: @media_folder.id}, format: :turbo_stream}
        assert_not_empty @media_folder.images
      end

    end
  end
end
