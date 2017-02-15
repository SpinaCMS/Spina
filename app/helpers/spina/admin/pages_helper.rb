module Spina
  module Admin
    module PagesHelper
      def link_to_add_structure_item_fields(f, association, &block)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
          build_structure_parts(f.object.page_part.name, new_object) if structure_item?(new_object)
          render("spina/admin/#{ partable_partial_namespace(new_object) }/fields", f: builder)
        end
        link_to '#', class: "#{add_structure_item_fields_class(new_object)} button button-link", data: {id: id, fields: fields.gsub("\n", "")} do
          block.yield
        end
      end

      def add_structure_item_fields_class(object)
        structure_item?(object) ? 'add_structure' : 'add_structure_item_fields'
      end

      def structure_item?(object)
        object.class.name.demodulize == "StructureItem"
      end

      def build_structure_parts(name, item)
        structure = current_theme.structures.find { |structure| structure[:name] == name }
        return item.structure_parts unless structure.present?
        structure[:structure_parts].map do |structure_part|
          part = item.structure_parts.where(name: structure_part[:name]).first
          if part.nil?
            part = item.structure_parts.build(structure_part)
            part.structure_partable = structure_part[:partable_type].constantize.new
          end
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
        pages = Spina::Page.active
        pages = pages.where.not(id: page.subtree.ids) unless page.new_record?

        flatten_nested_hash(pages.arrange(order: :position)).map do |page|
          next if page.depth >= Spina.config.max_page_depth - 1
          page_menu_title = page.depth.zero? ? page.menu_title : " #{page.menu_title}".indent(page.depth, '-')
          [page_menu_title, page.id]
        end.compact
      end

    end
  end
end
