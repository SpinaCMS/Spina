require "test_helper"

module Spina
  class PageTemplateTest < ActiveSupport::TestCase
    setup do
      PageTemplate.clear_all
    end

    teardown do
      PageTemplate.clear_all
    end

    test "defines parts and repeaters" do
      PageTemplate.with_theme("sample") do
        PageTemplate.define :homepage do
          title "Homepage"
          description "Front page for the site"
          part :header_background, :image
          part :header_text, :text
          part :hero_cta_link, :page_link
          part :case_study, "MyApp::Parts::CaseStudy"
          repeater :homepage_outcome_cards do
            part :title, :line
            part :image, :image
            part :text, :text
          end
        end
      end

      template = PageTemplate.for_theme("sample").first

      assert_equal "Homepage", template.title
      assert_equal "Front page for the site", template.description
      assert_equal %w[header_background header_text hero_cta_link case_study homepage_outcome_cards], template.part_names

      parts_by_name = template.part_definitions.index_by { |part| part[:name] }
      assert_equal "Spina::Parts::Image", parts_by_name["header_background"][:part_type]
      assert_equal "MyApp::Parts::CaseStudy", parts_by_name["case_study"][:part_type]
      assert_equal %w[title image text], parts_by_name["homepage_outcome_cards"][:parts]
    end

    test "allows the same part name with different definitions across page templates" do
      PageTemplate.with_theme("sample") do
        PageTemplate.define :first do
          part :title, :line
        end

        PageTemplate.define :second do
          part :title, :text
        end
      end

      first = PageTemplate.for_theme("sample").find { |template| template.name == "first" }
      second = PageTemplate.for_theme("sample").find { |template| template.name == "second" }

      assert_equal "Spina::Parts::Line", first.part_definitions.find { |part| part[:name] == "title" }[:part_type]
      assert_equal "Spina::Parts::Text", second.part_definitions.find { |part| part[:name] == "title" }[:part_type]
    end

    test "raises when the same part is defined differently within a page template" do
      assert_raises(ArgumentError) do
        PageTemplate.with_theme("sample") do
          PageTemplate.define :homepage do
            part :title, :line
            part :title, :text
          end
        end
      end
    end
  end
end
