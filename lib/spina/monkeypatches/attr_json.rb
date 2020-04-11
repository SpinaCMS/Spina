module Spina
  module AttrJsonPolymorphicModelDecorator

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

AttrJson::Type::PolymorphicModel.send :prepend, Spina::AttrJsonPolymorphicModelDecorator