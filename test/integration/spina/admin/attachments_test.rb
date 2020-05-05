require 'test_helper'

module Spina
  module Admin
    class AttachmentsTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
        post "/admin/sessions", params: {email: @user.email, password: "password"}
      end

      test "view table of all attachments" do
        get "/admin/attachments"
        assert_select 'th', 'Filename'
      end

      test "upload a new document" do
        spina_png = fixture_file_upload('/files/spina.png','image/png')
        post "/admin/attachments", params: {attachment: {files: [spina_png]}, format: :js}
        get "/admin/attachments"
        assert_select 'table a', 'spina.png'
      end

    end
  end
end
