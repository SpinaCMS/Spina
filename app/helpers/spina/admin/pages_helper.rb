module Spina
  module Admin
    module PagesHelper
      def link_to_add_fields(f, association, &block)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
          render(association.to_s.singularize + "_fields", f: builder)
        end
        link_to '#', class: "add_fields button", data: {id: id, fields: fields.gsub("\n", "")} do
          block.yield
        end
      end

      def link_to_add_structure(f, association, &block)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
          current_theme.config.structures[f.object.page_part.name].each do |structure_part|
            structure_part = new_object.structure_parts.build(structure_part)
            structure_part.structure_partable = structure_part.structure_partable_type.constantize.new
          end

          render(association.to_s.singularize + "_fields", f: builder)
        end
        link_to '#', class: "add_structure button button-link", data: {id: id, fields: fields.gsub("\n", "")} do
          block.yield
        end
      end
    end
  end
end
