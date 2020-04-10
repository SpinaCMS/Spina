module Spina
  module Parts
    class RepeaterContent < Base
      include AttrJson::NestedAttributes

      attr_json :parts, AttrJson::Type::PolymorphicModel.new(Spina::Parts::Line), array: true
      attr_json_accepts_nested_attributes_for :parts
    end
  end
end