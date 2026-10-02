require "test_helper"

module Spina
  class PartTypeTest < ActiveSupport::TestCase
    test "resolves built-in symbols to class names" do
      assert_equal "Spina::Parts::Line", PartType.resolve(:line)
      assert_equal "Spina::Parts::Text", PartType.resolve(:text)
      assert_equal "Spina::Parts::PageLink", PartType.resolve(:page_link)
    end

    test "passes through string class names" do
      assert_equal "MyApp::Parts::CaseStudy", PartType.resolve("MyApp::Parts::CaseStudy")
    end

    test "resolves class constants" do
      assert_equal "Spina::Parts::Image", PartType.resolve(Spina::Parts::Image)
    end

    test "raises for unknown symbols" do
      assert_raises(PartType::UnknownPartType) do
        PartType.resolve(:case_study)
      end
    end

    test "symbol_for returns built-in symbol" do
      assert_equal :image, PartType.symbol_for("Spina::Parts::Image")
      assert_nil PartType.symbol_for("MyApp::Parts::CaseStudy")
    end
  end
end
