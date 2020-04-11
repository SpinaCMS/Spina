module Spina
  module Admin
    module PagesHelper

      def link_to_add_repeater_fields(f, &block)
        repeater_content = Spina::Parts::RepeaterContent.new(name: "repeater", title: "Title")
        fields = f.fields_for(:content, [repeater_content], child_index: repeater_content.object_id) do |builder|
          render("spina/admin/parts/repeaters/fields", f: builder)
        end
        link_to '#', class: "add_structure_item_fields button button-link", data: {id: repeater_content.object_id, fields: fields.gsub("\n", "")} do
          icon('plus')
        end
      end

      def build_parts(partable, parts_attributes)
        I18n.with_locale(@locale) do
          parts_attributes.map do |part_attributes|
            partable.part(part_attributes)
          end
        end
      end

      def parts_partial_namespace(part_type)
        part_type.tableize.sub(/\Aspina\/parts\//, '')
      end

      def flatten_nested_hash(hash)
        hash.flat_map{|k, v| [k, *flatten_nested_hash(v)]}
      end

      def page_ancestry_options(page)
        pages = Spina::Page.active.regular_pages
        pages = pages.where.not(id: page.subtree.ids) unless page.new_record? || !page.methods.include?(:subtree)

        (flatten_nested_hash(pages.arrange(order: :position)).map do |page|
          next if page.depth >= Spina.config.max_page_depth - 1
          page_menu_title = page.depth.zero? ? page.menu_title : " #{page.menu_title}".indent(page.depth, '-')
          [page_menu_title, page.id]
        end << [page.parent&.menu_title, page&.parent_id].compact).uniq.compact
      end

      def option_label(part, value)
        t(['options',part.name,value].compact.join('.'))
      end

    end
  end
end
