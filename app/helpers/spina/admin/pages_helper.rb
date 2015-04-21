module Spina
  module Admin
    module PagesHelper
      def link_to_add_fields(f, association, &block)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
          build_structure_parts(f.object.page_part.name, new_object) if structure_item?(new_object)
          render(association.to_s.singularize + "_fields", f: builder)
        end
        link_to '#', class: "#{add_fields_class(new_object)} button button-link", data: {id: id, fields: fields.gsub("\n", "")} do
          block.yield
        end
      end

      def add_fields_class(object)
        structure_item?(object) ? 'add_structure' : 'add_fields'
      end

      def structure_item?(object)
        object.class.name.demodulize == "StructureItem"
      end

      def build_structure_parts(name, item)
        current_theme.config.structures[name].each do |part|
          part = item.structure_parts.build(part)
          part.structure_partable = part.structure_partable_type.constantize.new
        end
      end
    end
  end
end
