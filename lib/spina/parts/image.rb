module Spina
  module Parts
    class Image < Part

      def content
        self
      end

      def image_urls
        ["image_url", "thumb_url"]
      end

      def file
        Spina::Image.find_by(id: value["id"])&.file
      end

      def thumbnail_url
        value["thumb_url"]
      end

      def image_url
        value["image_url"]
      end
      
    end
  end
end