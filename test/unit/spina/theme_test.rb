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
      path = Rails.root.join("app/templates/spina/demo/homepage.rb")
      assert path.exist?
      assert Rails.autoloaders.main.__ignores?(path.to_s)
    end

    test "loads layout parts from layout.rb" do
      templates_dir = Rails.root.join("test/fixtures/templates/sample")
      FileUtils.mkdir_p(templates_dir)

      File.write(templates_dir.join("layout.rb"), <<~RUBY)
        Spina.define_layout_parts do
          part :footer_text, :text
        end
      RUBY

      File.write(templates_dir.join("homepage.rb"), <<~RUBY)
        Spina.define_template :homepage do
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

    test "loads sectioned layout parts from layout.rb" do
      templates_dir = Rails.root.join("test/fixtures/templates/sectioned")
      FileUtils.mkdir_p(templates_dir)

      File.write(templates_dir.join("layout.rb"), <<~RUBY)
        Spina.define_layout_parts do
          section :general do
            part :footer, :text
            part :logo, :image
          end

          section :seo do
            part :footer, :text
            part :meta_title, :line
          end
        end
      RUBY

      Theme.register do |theme|
        theme.name = "sectioned"
        theme.title = "Sectioned Theme"
        theme.load_templates_from templates_dir
      end

      theme = Theme.find_by_name("sectioned")

      assert_equal({general: %w[footer logo], seo: %w[footer meta_title]}, theme.layout_parts)
      assert_equal %w[footer logo meta_title].sort, theme.layout_part_definitions.map { |part| part[:name] }.sort
    ensure
      FileUtils.rm_rf(templates_dir)
    end

    test "loads page templates from the default templates path" do
      templates_dir = Rails.root.join("test/fixtures/templates/sample")
      FileUtils.mkdir_p(templates_dir)

      File.write(templates_dir.join("homepage.rb"), <<~RUBY)
        Spina.define_template :homepage do
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
        Spina.define_template :homepage do
          part :some_content, :text
        end
      RUBY

      File.write(templates_dir.join("show.rb"), <<~RUBY)
        Spina.define_template :show do
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

    test "loads nested repeaters and preserves options keys" do
      templates_dir = Rails.root.join("test/fixtures/templates/nested")
      FileUtils.mkdir_p(templates_dir)

      File.write(templates_dir.join("show.rb"), <<~RUBY)
        Spina.define_template :show do
          repeater :sections, options: {max: 5} do
            part :heading, :line
            repeater :items, item_name: "item" do
              part :label, :line
              part :alignment, :option, options: %w[left right]
            end
          end
        end
      RUBY

      Theme.register do |theme|
        theme.name = "nested"
        theme.title = "Nested Theme"
        theme.load_templates_from templates_dir
      end

      theme = Theme.find_by_name("nested")
      parts = theme.part_definitions_for(:page, view_template: "show")

      sections = parts.find { |part| part[:name] == "sections" }
      items = parts.find { |part| part[:name] == "items" }
      alignment = parts.find { |part| part[:name] == "alignment" }

      assert_equal "Spina::Parts::Repeater", sections[:part_type]
      assert_equal({max: 5}, sections[:options])
      assert_equal %w[heading items], sections[:parts]
      assert_equal "item", items[:item_name]
      assert_equal %w[label alignment], items[:parts]
      assert_equal %w[left right], alignment[:options]
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

    test "concurrent theme registration keeps template registries isolated" do
      templates_root = Rails.root.join("test/fixtures/templates")
      FileUtils.mkdir_p(templates_root.join("tenant_a"))
      FileUtils.mkdir_p(templates_root.join("tenant_b"))

      File.write(templates_root.join("tenant_a/homepage.rb"), <<~RUBY)
        Spina.define_template :homepage do
          part :tenant_a_only, :text
        end
      RUBY

      File.write(templates_root.join("tenant_b/homepage.rb"), <<~RUBY)
        Spina.define_template :homepage do
          part :tenant_b_only, :line
        end
      RUBY

      ready = Queue.new
      go = Queue.new
      errors = []

      threads = [
        Thread.new do
          ready << :a
          go.pop
          Theme.register do |theme|
            theme.name = "tenant_a"
            theme.title = "Tenant A"
            theme.load_templates_from templates_root.join("tenant_a")
          end
        rescue => error
          errors << error
        end,
        Thread.new do
          ready << :b
          go.pop
          Theme.register do |theme|
            theme.name = "tenant_b"
            theme.title = "Tenant B"
            theme.load_templates_from templates_root.join("tenant_b")
          end
        rescue => error
          errors << error
        end
      ]

      2.times { ready.pop }
      2.times { go << true }
      threads.each(&:join)

      assert_empty errors

      theme_a = Theme.find_by_name("tenant_a")
      theme_b = Theme.find_by_name("tenant_b")

      assert_equal %w[tenant_a_only], theme_a.view_templates.first[:parts]
      assert_equal %w[tenant_b_only], theme_b.view_templates.first[:parts]
      assert_equal "Spina::Parts::Text", theme_a.part_definitions_for(:page, view_template: "homepage").first[:part_type]
      assert_equal "Spina::Parts::Line", theme_b.part_definitions_for(:page, view_template: "homepage").first[:part_type]
    ensure
      FileUtils.rm_rf(templates_root.join("tenant_a"))
      FileUtils.rm_rf(templates_root.join("tenant_b"))
    end

    test "raises a clear error when legacy config and page template files both exist" do
      templates_dir = Rails.root.join("test/fixtures/templates/conflict")
      FileUtils.mkdir_p(templates_dir)

      File.write(templates_dir.join("homepage.rb"), <<~RUBY)
        Spina.define_template :homepage do
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
