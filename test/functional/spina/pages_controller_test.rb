require 'test_helper'

module Spina
  class PagesControllerTest < ActionController::TestCase
    setup do
      I18n.locale = :en
      @routes = Engine.routes
      @current_account = FactoryBot.create :account
    end

    test "visit homepage" do
      get :homepage
      assert_response :success
    end
  end
end
