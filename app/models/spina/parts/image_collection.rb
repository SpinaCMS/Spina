module Spina
  module Parts
    class ImageCollection < Base
      include AttrJson::NestedAttributes
      
      attr_json :images, Image.to_type, array: true
      attr_json_accepts_nested_attributes_for :images

      def to_s
        Spina::Parts::ImageCollection.model_name.human
      end

      def content
        (images || [])
      end

      def image_ids
        content.map(&:image_id)
      end

    end
  end
end