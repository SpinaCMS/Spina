require "test_helper"

module Spina
  class PageTemplatesCompilerTest < ActiveSupport::TestCase
    setup do
      PageTemplate.clear_all
    end

    teardown do
      PageTemplate.clear_all
    end

    test "compiles page templates into view templates" do
      PageTemplate.with_theme("sample") do
        PageTemplate.define :homepage do
          title "Homepage"
          part :header_background, :image
          repeater :homepage_outcome_cards do
            part :title, :line
            part :image, :image
            part :text, :text
          end
        end

        PageTemplate.define :show do
          title "Content Page"
          part :header_background, :image
          part :text, :text
        end
      end

      compiled = PageTemplatesCompiler.new(PageTemplate.for_theme("sample"))

      assert_equal 2, compiled.view_templates.size

      homepage = compiled.view_templates.find { |template| template[:name] == "homepage" }
      assert_equal %w[header_background homepage_outcome_cards], homepage[:parts]
    end

    test "keeps layout part definitions separate from page templates" do
      layout_parts = nil

      LayoutParts.with_theme("sample") do
        layout_parts = LayoutParts::Definition.new("sample")
        layout_parts.part :footer_text, :text
        layout_parts.part :tag_line, :line
      end

      PageTemplate.with_theme("sample") do
        PageTemplate.define :homepage do
          part :tag_line, :line
          part :text, :text
        end
      end

      compiled = PageTemplatesCompiler.new(PageTemplate.for_theme("sample"), layout_parts: layout_parts)

      assert_equal %w[footer_text tag_line], compiled.layout_part_names
      assert_equal 2, compiled.layout_part_definitions.size
    end

    test "allows the same part name with different definitions in layout and page templates" do
      layout_parts = LayoutParts::Definition.new("sample")
      layout_parts.part :some_content, :text

      PageTemplate.with_theme("sample") do
        PageTemplate.define :homepage do
          part :some_content, :line
        end
      end

      compiled = PageTemplatesCompiler.new(PageTemplate.for_theme("sample"), layout_parts: layout_parts)
      homepage = PageTemplate.for_theme("sample").first

      layout_part = compiled.layout_part_definitions.find { |part| part[:name] == "some_content" }
      page_part = homepage.part_definitions.find { |part| part[:name] == "some_content" }

      assert_equal "Spina::Parts::Text", layout_part[:part_type]
      assert_equal "Spina::Parts::Line", page_part[:part_type]
    end

    test "allows the same part name with different definitions across page templates" do
      PageTemplate.with_theme("sample") do
        PageTemplate.define :homepage do
          part :some_content, :text
        end

        PageTemplate.define :show do
          part :some_content, :line
        end
      end

      homepage = PageTemplate.for_theme("sample").find { |template| template.name == "homepage" }
      show = PageTemplate.for_theme("sample").find { |template| template.name == "show" }

      homepage_part = homepage.part_definitions.find { |part| part[:name] == "some_content" }
      show_part = show.part_definitions.find { |part| part[:name] == "some_content" }

      assert_equal "Spina::Parts::Text", homepage_part[:part_type]
      assert_equal "Spina::Parts::Line", show_part[:part_type]
    end
  end
end
