module Spina
  module Parts
    class ImageCollection < Base
      attr_json :image_tokens, :string, default: ""

      def image_ids
        image_tokens.split(",").map(&:to_i)
      end

      def images
        @images ||= Spina::Image.where(id: image_ids).sort_by do |image|
          image_ids.index(image.id)
        end
      end

    end
  end
end