module Spina
  module Parts
    class ImageCollection < Base
      include AttrJson::NestedAttributes
      
      attr_json :image_tokens, :string, default: ""
      attr_json :image_objects, Image.to_type, array: true
      attr_json_accepts_nested_attributes_for :image_objects

      def image_ids
        image_tokens.split(",").map(&:to_i)
      end

      def images
        @images ||= Spina::Image.where(id: image_ids).sort_by do |image|
          image_ids.index(image.id)
        end
      end

      def content
        image_objects
      end

    end
  end
end