module Spina
  module Admin
    module PagesHelper
      def link_to_add_structure_item_fields(f, &block)
        item = StructureItem.new
        fields = f.fields_for(:structure_items, item, child_index: item.object_id) do |builder|
          build_structure_parts(f.object.page_part.name, item)
          render("spina/admin/structure_items/fields", f: builder)
        end
        link_to '#', class: "add_structure_item_fields button button-link", data: {id: item.object_id, fields: fields.gsub("\n", "")} do
          icon('plus')
        end
      end

      def build_structure_parts(name, item)
        structure = current_theme.structures.find { |structure| structure[:name] == name }
        return item.parts unless structure.present?
        structure[:structure_parts].map do |attributes|
          part = item.parts.where(name: attributes[:name]).first_or_initialize(attributes)
          part.partable = part.partable_type.constantize.new if part.partable.blank?
          part.options = attributes[:options]
          part
        end
      end

      def partable_partial_namespace(partable)
        partable_type_partial_namespace(partable.model_name.to_s)
      end

      def partable_type_partial_namespace(partable_type)
        partable_type.tableize.sub(/\Aspina\//, '')
      end

      def flatten_nested_hash(hash)
        hash.flat_map{|k, v| [k, *flatten_nested_hash(v)]}
      end

      def page_ancestry_options(page)
        pages = Spina::Page.active.regular_pages
        pages = pages.where.not(id: page.subtree.ids) unless page.new_record? || !page.methods.include?(:subtree)

        flatten_nested_hash(pages.arrange(order: :position)).map do |page|
          next if page.depth >= Spina.config.max_page_depth - 1
          page_menu_title = page.depth.zero? ? page.menu_title : " #{page.menu_title}".indent(page.depth, '-')
          [page_menu_title, page.id]
        end.compact
      end

      def option_label(part, value)
        t(['options',part.name,value].compact.join('.'))
      end

    end
  end
end
