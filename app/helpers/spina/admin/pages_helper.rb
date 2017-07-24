module Spina
  module Admin
    module PagesHelper
      def link_to_add_structure_item_fields(f, association, &block)
        item = build_structure_item(f.object)
        fields = f.fields_for(association, item, child_index: item.object_id) do |builder|
          render("spina/admin/structure_items/fields", f: builder)
        end
        link_to '#', class: "add_structure_item_fields button button-link", data: {id: item.object_id, fields: fields.gsub("\n", "")} do
          icon('plus')
        end
      end

      def build_structure_item(object)
        item = object.structure_items.new
        build_structure_parts(object.page_part.name, item)
        item
      end

      def build_structure_parts(name, item)
        structure = current_theme.structures.find { |structure| structure[:name] == name }
        return item.parts unless structure.present?
        structure[:structure_parts].map do |structure_part|
          options = structure_part[:options]
          part = item.parts.where(name: structure_part[:name]).first
          if part.nil?
            part = item.parts.build(structure_part)
            part.structure_partable = structure_part[:partable_type].constantize.new
          end
          part.options = options
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

      def option_label(part, value)
        t(['options',part.name,value].compact.join('.'))
      end

    end
  end
end
