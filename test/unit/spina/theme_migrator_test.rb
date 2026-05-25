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
        {name: "cards", title: "Cards", part_type: "Spina::Parts::Repeater", parts: %w[title image]},
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
      assert_includes layout, "LayoutParts.define do"
      assert_includes layout, 'part "line", :line'
      assert_includes layout, 'part "body", :text'

      homepage = File.read(output_dir.join("homepage.rb"))
      assert_includes homepage, 'PageTemplate.define "homepage" do'
      assert_includes homepage, 'description "Front page"'
      refute_includes homepage, 'title "Homepage"'
      assert_includes homepage, "part \"line\", :line"
      assert_includes homepage, "part \"case_study\", \"MyApp::Parts::CaseStudy\""
      assert_includes homepage, "repeater \"cards\" do"
      assert_includes homepage, "part \"title\", :line, title: \"Card title\""

      initializer = migrator.slim_initializer_content
      assert_includes initializer, 'theme.load_templates_from "app/templates/spina/demo"'
      assert_includes initializer, "layout.rb"
      refute_includes initializer, "theme.layout_parts"
      refute_includes initializer, "theme.parts"
      refute_includes initializer, "theme.view_templates"
    ensure
      FileUtils.rm_rf(Rails.root.join("tmp/theme_migrator"))
    end
  end
end
