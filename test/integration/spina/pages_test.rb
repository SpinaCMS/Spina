require 'test_helper'

module Spina
  class PagesTest < ActionDispatch::IntegrationTest
    setup do
      @routes = Engine.routes
    end

    test "view homepage" do
      get "/"
      assert_select 'h1', 'Homepage'
    end

    test "view show page" do
      get "/about"
      assert_select 'h1', 'About'
    end
  end
end
