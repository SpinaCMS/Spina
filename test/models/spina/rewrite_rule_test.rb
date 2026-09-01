require "test_helper"

module Spina
  class RewriteRuleTest < ActiveSupport::TestCase
    test "record creates a rewrite rule" do
      RewriteRule.record("/a", "/b")

      assert_equal [["/a", "/b"]], RewriteRule.pluck(:old_path, :new_path)
    end

    test "record skips blank or unchanged paths" do
      RewriteRule.record(nil, "/a")
      RewriteRule.record("", "/a")
      RewriteRule.record("/a", "/a")

      assert_empty RewriteRule.all
    end

    test "record updates an existing rule for the same old_path" do
      RewriteRule.record("/a", "/b")
      RewriteRule.record("/a", "/c")

      assert_equal [["/a", "/c"]], RewriteRule.pluck(:old_path, :new_path)
    end

    test "renaming back does not leave a redirect loop" do
      RewriteRule.record("/a", "/b")
      RewriteRule.record("/b", "/a")

      assert_equal [["/b", "/a"]], RewriteRule.pluck(:old_path, :new_path)
    end

    test "renaming again does not leave a redirect chain" do
      RewriteRule.record("/a", "/b")
      RewriteRule.record("/b", "/c")

      assert_equal [["/a", "/c"], ["/b", "/c"]], RewriteRule.pluck(:old_path, :new_path).sort
    end
  end
end
