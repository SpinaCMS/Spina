module Spina
  module Parts
    class RepeaterContent < Base
      include Partable
      include AttrJson::NestedAttributes

      attr_json :parts, AttrJson::Type::PolymorphicModel.new(*Spina::PARTS), array: true
      attr_json_accepts_nested_attributes_for :parts

      def available_parts
        [{
          name: 'line',
          title: "Line",
          part_type: "Spina::Parts::Line"
        }, {
          name: 'body',
          title: "Body",
          part_type: "Spina::Parts::Text"
        }, {
          name: "image_collection",
          title: "Image collection",
          part_type: "Spina::Parts::ImageCollection"
        }]
      end

    end
  end
end