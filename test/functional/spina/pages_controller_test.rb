require 'test_helper'

module Spina
  class PagesControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
      @current_account = FactoryGirl.create :account
    end

    test "visit homepage" do
      get :homepage
      assert_response :success
    end
  end
end
