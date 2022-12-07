require "test_helper"

module Spina
  class PagesControllerTest < ActionController::TestCase
    setup do
      I18n.locale = :en
      @routes = Engine.routes
      @current_spina_account = FactoryBot.create :account
    end

    test "visit homepage" do
      get :homepage
      assert_response :success
    end

    test "instance variable from parent application controller is set" do
      get :homepage
      assert_not_nil assigns(:some_variable)
    end
  end
end
