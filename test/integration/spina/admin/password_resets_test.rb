require 'test_helper'

module Spina
  module Admin
    class PasswordResetsTest < ActionDispatch::IntegrationTest
      setup do
        @routes = Engine.routes
        @account = FactoryBot.create :account
        @user = FactoryBot.create :user
      end

      test "new password form" do
        get "/admin/password_resets/new"
        assert_select '#login_wrapper'
      end

      test "request new password" do
        post "/admin/password_resets", params: {email: "bram@denkgroot.com"}
        follow_redirect!
        assert_select '#login_wrapper'

        mail = ActionMailer::Base.deliveries.last
        assert_equal 'bram@denkgroot.com', mail['to'].to_s
      end

    end
  end
end
