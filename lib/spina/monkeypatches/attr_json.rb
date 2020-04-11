# It's hard to allow AttrJson to accept any model for Polymorphic attributes
# It's not really safe to depend on model_name.constantize so instead
# we've introduced an array Spina::PARTS which will be used for lookup 
# as opposed to attr_json's default behavior for polymorphic attributes.

# It's an ugly hack, should replace with something else later
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