require "test_helper"

module Spina
  class ThemeTest < ActiveSupport::TestCase
    setup do
      PageTemplate.clear_all
      LayoutParts.clear_all
      @previous_themes = Theme.all.dup
      Theme.all.clear
    end

    teardown do
      PageTemplate.clear_all
      LayoutParts.clear_all
      Theme.all.clear
      Theme.all.concat(@previous_themes)
    end

    test "page template files are ignored by zeitwerk" do
      templates_path = Rails.root.join("app/templates").to_s
      ignored_paths = Rails.autoloaders.main.send(:ignored_paths).map(&:to_s)

      assert_includes ignored_paths, templates_path
    end

    test "loads layout parts from layout.rb" do
      templates_dir = Rails.root.join("test/fixtures/templates/sample")
      FileUtils.mkdir_p(templates_dir)

      File.write(templates_dir.join("layout.rb"), <<~RUBY)
        LayoutParts.define do
          part :footer_text, :text
        end
      RUBY

      File.write(templates_dir.join("homepage.rb"), <<~RUBY)
        PageTemplate.define :homepage do
          part :text, :text
        end
      RUBY

      Theme.register do |theme|
        theme.name = "sample"
        theme.title = "Sample Theme"
        theme.load_templates_from templates_dir
      end

      theme = Theme.find_by_name("sample")

      assert_equal %w[footer_text], theme.layout_parts
      assert theme.layout_part_definitions.any? { |part| part[:name] == "footer_text" }
      assert theme.part_definitions_for(:page, view_template: "homepage").any? { |part| part[:name] == "text" }
      refute theme.part_definitions_for(:page, view_template: "homepage").any? { |part| part[:name] == "footer_text" }
    ensure
      FileUtils.rm_rf(templates_dir)
    end

    test "loads page templates from the default templates path" do
      templates_dir = Rails.root.join("test/fixtures/templates/sample")
      FileUtils.mkdir_p(templates_dir)

      File.write(templates_dir.join("homepage.rb"), <<~RUBY)
        PageTemplate.define :homepage do
          title "Homepage"
          part :text, :text, title: "Body", hint: "Your main content"
        end
      RUBY

      Theme.register do |theme|
        theme.name = "sample"
        theme.title = "Sample Theme"
        theme.load_templates_from templates_dir
      end

      theme = Theme.find_by_name("sample")

      assert_equal 1, theme.view_templates.size
      assert_equal "homepage", theme.view_templates.first[:name]
      assert_equal %w[text], theme.view_templates.first[:parts]

      text_part = theme.part_definitions_for(:page, view_template: "homepage").find { |part| part[:name] == "text" }
      assert_equal "Spina::Parts::Text", text_part[:part_type]
      assert_equal "Body", text_part[:title]
      assert_equal "Your main content", text_part[:hint]

      PageTemplate.clear_all
      text_part = theme.part_definitions_for(:page, view_template: "homepage").find { |part| part[:name] == "text" }
      assert_equal "Spina::Parts::Text", text_part[:part_type]
    ensure
      FileUtils.rm_rf(Rails.root.join("test/fixtures/templates/sample"))
    end

    test "allows the same part name with different definitions across page templates" do
      templates_dir = Rails.root.join("test/fixtures/templates/sample")
      FileUtils.mkdir_p(templates_dir)

      File.write(templates_dir.join("homepage.rb"), <<~RUBY)
        PageTemplate.define :homepage do
          part :some_content, :text
        end
      RUBY

      File.write(templates_dir.join("show.rb"), <<~RUBY)
        PageTemplate.define :show do
          part :some_content, :line
        end
      RUBY

      Theme.register do |theme|
        theme.name = "sample"
        theme.title = "Sample Theme"
        theme.load_templates_from templates_dir
      end

      theme = Theme.find_by_name("sample")

      homepage_part = theme.part_definitions_for(:page, view_template: "homepage").find { |part| part[:name] == "some_content" }
      show_part = theme.part_definitions_for(:page, view_template: "show").find { |part| part[:name] == "some_content" }

      assert_equal "Spina::Parts::Text", homepage_part[:part_type]
      assert_equal "Spina::Parts::Line", show_part[:part_type]
    ensure
      FileUtils.rm_rf(templates_dir)
    end

    test "warns when legacy theme configuration is used" do
      Theme.legacy_theme_warnings.delete("legacy-theme-test")

      assert_deprecated do
        Theme.register do |theme|
          theme.name = "legacy-theme-test"
          theme.title = "Legacy Theme"
          theme.parts = [{name: "text", title: "Text", part_type: "Spina::Parts::Text"}]
          theme.view_templates = [{name: "show", title: "Show", parts: %w[text]}]
        end
      end
    end

    test "raises a clear error when legacy config and page template files both exist" do
      templates_dir = Rails.root.join("test/fixtures/templates/conflict")
      FileUtils.mkdir_p(templates_dir)

      File.write(templates_dir.join("homepage.rb"), <<~RUBY)
        PageTemplate.define :homepage do
          part :text, :text
        end
      RUBY

      error = assert_raises(ArgumentError) do
        Theme.register do |theme|
          theme.name = "conflict"
          theme.title = "Conflict Theme"
          theme.parts = [{name: "text", title: "Text", part_type: "Spina::Parts::Text"}]
          theme.load_templates_from templates_dir
        end
      end

      assert_includes error.message, "uses both the legacy theme configuration and page template files"
      assert_includes error.message, "Remove `theme.parts` and `theme.view_templates`"
      assert_includes error.message, "spina:theme:migrate_templates[conflict]"
      assert_includes error.message, "conflict.rb.bak"
    ensure
      FileUtils.rm_rf(Rails.root.join("test/fixtures/templates/conflict"))
    end

    private

    def assert_deprecated(&block)
      Spina.deprecator.expects(:warn).with do |message|
        message.include?("theme.parts and theme.view_templates")
      end.at_least_once

      block.call
    end
  end
end
