require 'test_helper'

module Spina
  class PageTest < ActiveSupport::TestCase
    test "#set_materialized_path assigns the parameterized page title" do
      page = FactoryGirl.create :page, name: "new page", title: "My Great Page Title!"
      assert_equal "/my-great-page-title", page.materialized_path
    end

    test "set_materialized_path assigns a generated path fragment when parameterized page title is blank" do
      page = FactoryGirl.create :page, name: "new page", title: "我伟大的页面标题 我伟大的页面标题 我"
      assert_equal "/我伟大的页面标题-我伟大的页面标题-我", page.materialized_path
    end
  end
end
