require 'test_helper'

module Spina
  module Admin
    class SessionsControllerTest < ActionController::TestCase
      setup do
        @routes = ::Spina::Engine.routes
        @user = FactoryBot.create :user
      end

      test "login renders the correct layout" do
        get :new
        assert_template layout: 'spina/login'
      end

      test "should be able to login" do
        post :create, params: {email: @user.email, password: "password"}
        assert_not_nil session[:user_id]
      end

      test "should be able to logout" do
        get :destroy
        assert_nil session[:user_id]
      end

      test "should alert the user when wrong password" do
        post :create, params: {email: @user.email, password: "1234"}
        assert_nil session[:user_id]
        assert_not_empty flash[:alert]
      end
    end
  end
end
