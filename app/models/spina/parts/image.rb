module Spina
  module Parts
    class Image < Base
      attr_json :image_id, :integer, default: nil
      attr_json :alt, :string, default: ""

      def image
        @image ||= Spina::Image.find_by(id: image_id)
      end
    end
  end
end
