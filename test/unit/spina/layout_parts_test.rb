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

    test "Spina.define_layout_parts delegates to LayoutParts.define" do
      LayoutParts.with_theme("sample") do
        Spina.define_layout_parts do
          part :footer, :text
        end
      end

      definition = LayoutParts.for_theme("sample")
      assert_equal %w[footer], definition.part_names
    end

    test "defines layout parts in sections" do
      LayoutParts.with_theme("sample") do
        LayoutParts.define do
          section :general do
            part :footer, :text
          end

          section :seo do
            part :meta_title, :line
          end
        end
      end

      definition = LayoutParts.for_theme("sample")

      assert_equal({general: %w[footer], seo: %w[meta_title]}, definition.layout_part_names)
      assert_equal %w[footer meta_title], definition.part_names
    end

    test "raises when mixing unsectioned parts with sections" do
      assert_raises(ArgumentError) do
        LayoutParts.with_theme("sample") do
          LayoutParts.define do
            part :footer, :text
            section :seo do
              part :meta_title, :line
            end
          end
        end
      end
    end

    test "isolates current theme name per thread" do
      ready = Queue.new
      go = Queue.new
      results = {}

      threads = [
        Thread.new do
          LayoutParts.with_theme("tenant_a") do
            ready << :a
            go.pop
            results[:a] = LayoutParts.current_theme_name
            sleep 0.05
            results[:a_after] = LayoutParts.current_theme_name
          end
        end,
        Thread.new do
          LayoutParts.with_theme("tenant_b") do
            ready << :b
            go.pop
            results[:b] = LayoutParts.current_theme_name
            sleep 0.05
            results[:b_after] = LayoutParts.current_theme_name
          end
        end
      ]

      2.times { ready.pop }
      2.times { go << true }
      threads.each(&:join)

      assert_equal "tenant_a", results[:a]
      assert_equal "tenant_a", results[:a_after]
      assert_equal "tenant_b", results[:b]
      assert_equal "tenant_b", results[:b_after]
    end
  end
end
