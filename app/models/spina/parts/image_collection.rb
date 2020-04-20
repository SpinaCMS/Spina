module Spina
  module Parts
    class ImageCollection < Base
      include AttrJson::NestedAttributes
      
      attr_json :images, Image.to_type, array: true
      attr_json_accepts_nested_attributes_for :images

      def content
        (images || [])
      end

      def image_ids
        content.map(&:image_id)
      end

    end
  end
end