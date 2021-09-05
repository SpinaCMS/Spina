require 'test_helper'

module Spina
  module Admin
    class PasswordResetsTest < ActionDispatch::IntegrationTest
      setup do
        host! "dummy.test"

        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
      end

      test "new password form" do
        get "/admin/password_resets/new"
        assert_select 'form', action: "/admin/sessions"
      end

      test "request new password" do
        post "/admin/password_resets", params: {email: "bram@denkgroot.com"}
        follow_redirect!
        assert_select 'form', action: "/admin/sessions"

        assert_enqueued_email_with UserMailer, :forgot_password, args: [@user, nil]
      end

    end
  end
end
