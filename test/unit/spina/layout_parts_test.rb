require "test_helper"

module Spina
  class LayoutPartsTest < ActiveSupport::TestCase
    setup do
      LayoutParts.clear_all
    end

    teardown do
      LayoutParts.clear_all
    end

    test "defines global layout parts" do
      LayoutParts.with_theme("sample") do
        LayoutParts.define do
          part :tag_line, :line
          part :footer_text, :text, title: "Footer Text"
        end
      end

      definition = LayoutParts.for_theme("sample")

      assert_equal %w[tag_line footer_text], definition.part_names
      assert_equal "Spina::Parts::Line", definition.part_definitions.find { |p| p[:name] == "tag_line" }[:part_type]
    end
  end
end
