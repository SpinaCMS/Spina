require 'test_helper'

module Spina
  class PagesControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    def test_homepage
      get :homepage
      assert_response :success
    end
  end
end
