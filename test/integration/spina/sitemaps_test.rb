require "test_helper"

module Spina
  class SitemapsTest < ActionDispatch::IntegrationTest
    setup do
      host! "dummy.test"

      @routes = Engine.routes
      @account = FactoryBot.create :account
    end

    test "Get sitemap" do
      get "/sitemap.xml"
      assert_select "urlset"
      assert_select "url"
    end
  end
end
