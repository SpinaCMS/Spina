require 'test_helper'

module Spina
  module Admin
    class MediaPickerTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
        post "/admin/sessions", params: {email: @user.email, password: "password"}
      end

      test "Show media picker with spina.png" do
        spina_png = fixture_file_upload('/files/spina.png','image/png')
        @image = Spina::Image.create(file: spina_png)
        get "/admin/media_picker"

        assert_select ".media-picker-image input[type='checkbox'][value='#{@image.id}']"
      end

    end
  end
end
