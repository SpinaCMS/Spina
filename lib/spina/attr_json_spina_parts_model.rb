require 'attr_json/type/polymorphic_model'

# Extending the PolymorphicModel to use the Spina::PARTS array as input
# as opposed to arguments
module AttrJson
  module Type
    class SpinaPartsModel < PolymorphicModel

      def model_names
        spina_parts_lookup.keys
      end

      def model_types
        spina_parts_lookup.values
      end

      def spina_parts_lookup
        @spina_parts_lookup ||= Spina::PARTS.map(&:to_type).map do |type|
          [type.model.name, type]
        end.to_h
      end

      def type_for_model_name(model_name)
        spina_parts_lookup[model_name]
      end

    end
  end
end
