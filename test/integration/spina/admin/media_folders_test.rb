require "test_helper"

module Spina
  module Admin
    class MediaFoldersTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
        post "/admin/sessions", params: {email: @user.email, password: @user.password}
      end

      test "create a new media folder" do
        media_folder_name = "My Media Folder"
        post "/admin/media_folders", params: {media_folder: {name: media_folder_name}}
        get "/admin/images"
        assert_select "turbo-frame div", media_folder_name
      end

      test "Show media folder" do
        @media_folder = FactoryBot.create :media_folder
        get "/admin/media_folders/#{@media_folder.id}/images"
        assert_select 'input#new_image_file_field[type="file"]'
      end

      test "Delete media folder" do
        @media_folder = FactoryBot.create :media_folder
        delete "/admin/media_folders/#{@media_folder.id}"
        get "/admin/images"
        assert_select ".media-folder-name", 0
      end

      test "Rename media folder" do
        @media_folder = FactoryBot.create :media_folder
        new_name = "New name for media folder"
        patch "/admin/media_folders/#{@media_folder.id}", params: {media_folder: {name: new_name}}
        get "/admin/images"
        assert_select "turbo-frame div", new_name
      end
    end
  end
end
