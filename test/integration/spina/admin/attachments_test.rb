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
        assert_select 'turbo-frame#attachments'
      end

      test "upload a new document" do
        spina_png = fixture_file_upload('spina.png','image/png')
        post "/admin/attachments", params: {attachment: {files: [spina_png]}}
        get "/admin/attachments"
        assert_select 'turbo-frame#attachments-1'
        assert_select 'span', 'spina.png'
      end

    end
  end
end
