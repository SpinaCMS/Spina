require "test_helper"

module Spina
  class ThemeMigratorTest < ActiveSupport::TestCase
    setup do
      @theme = Theme.new
      @theme.name = "demo"
      @theme.title = "Demo theme"
      @theme.layout_parts = %w[line body]
      @theme.custom_pages = [{name: "homepage", title: "Homepage", deletable: false, view_template: "homepage"}]
      @theme.parts = [
        {name: "line", title: "Line", part_type: "Spina::Parts::Line"},
        {name: "body", title: "Body", part_type: "Spina::Parts::Text"},
        {name: "title", title: "Card title", part_type: "Spina::Parts::Line"},
        {name: "image", title: "Image", part_type: "Spina::Parts::Image"},
        {name: "alignment", title: "Alignment", part_type: "Spina::Parts::Option", options: %w[left right center]},
        {name: "nested_items", title: "Nested items", part_type: "Spina::Parts::Repeater", parts: %w[title], item_name: "item", options: {max: 3}},
        {name: "cards", title: "Cards", part_type: "Spina::Parts::Repeater", parts: %w[title image nested_items alignment]},
        {name: "case_study", title: "Case Study", part_type: "MyApp::Parts::CaseStudy"}
      ]
      @theme.view_templates = [
        {name: "homepage", title: "Homepage", description: "Front page", parts: %w[line body cards case_study]}
      ]
    end

    test "generates page template files and slim initializer" do
      output_dir = Rails.root.join("tmp/theme_migrator/demo")
      FileUtils.rm_rf(output_dir)

      migrator = ThemeMigrator.new(@theme)
      migrator.migrate_to(output_dir)

      layout = File.read(output_dir.join("layout.rb"))
      assert_includes layout, "Spina.define_layout_parts do"
      assert_includes layout, 'part "line", :line'
      assert_includes layout, 'part "body", :text'

      homepage = File.read(output_dir.join("homepage.rb"))
      assert_includes homepage, 'Spina.define_template "homepage" do'
      assert_includes homepage, 'description "Front page"'
      refute_includes homepage, 'title "Homepage"'
      assert_includes homepage, "part \"line\", :line"
      assert_includes homepage, "part \"case_study\", \"MyApp::Parts::CaseStudy\""
      assert_includes homepage, "repeater \"cards\" do"
      assert_includes homepage, "part \"title\", :line, title: \"Card title\""
      assert_includes homepage, "part \"alignment\", :option, options: [\"left\", \"right\", \"center\"]"
      assert_match(/repeater "nested_items".*item_name: "item".*options:.*max.*do/, homepage)
      assert_match(/repeater "nested_items".*\n\s+part "title"/, homepage)

      initializer = migrator.slim_initializer_content
      assert_includes initializer, 'theme.load_templates_from "app/templates/spina/demo"'
      assert_includes initializer, "layout.rb"
      refute_includes initializer, "theme.layout_parts"
      refute_includes initializer, "theme.parts"
      refute_includes initializer, "theme.view_templates"
    ensure
      FileUtils.rm_rf(Rails.root.join("tmp/theme_migrator"))
    end

    test "raises before writing files when a part reference is missing" do
      output_dir = Rails.root.join("tmp/theme_migrator/missing")
      FileUtils.rm_rf(output_dir)
      @theme.view_templates = [
        {name: "homepage", title: "Homepage", parts: %w[line missing_part]}
      ]

      error = assert_raises(ThemeMigrator::MissingPartError) do
        ThemeMigrator.new(@theme).migrate_to(output_dir)
      end

      assert_includes error.message, "missing_part"
      refute File.exist?(output_dir.join("homepage.rb"))
    ensure
      FileUtils.rm_rf(Rails.root.join("tmp/theme_migrator"))
    end

    test "migrates sectioned layout parts" do
      output_dir = Rails.root.join("tmp/theme_migrator/sectioned")
      FileUtils.rm_rf(output_dir)
      @theme.name = "sectioned"
      @theme.layout_parts = {general: %w[line], seo: %w[body]}
      @theme.view_templates = []

      ThemeMigrator.new(@theme).migrate_to(output_dir)

      layout = File.read(output_dir.join("layout.rb"))
      assert_includes layout, "section :general do"
      assert_includes layout, 'part "line", :line'
      assert_includes layout, "section :seo do"
      assert_includes layout, 'part "body", :text'
    ensure
      FileUtils.rm_rf(Rails.root.join("tmp/theme_migrator"))
    end
  end
end
