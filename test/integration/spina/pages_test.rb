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

    # Globalize different languages
    test "view homepage in another language" do
      get "/nl"
      assert_select 'h1', 'Beginpagina'
    end

    test "view show page in another language" do
      get "/nl/over-ons"
      assert_select 'h1', 'Over ons'
    end
  end
end
