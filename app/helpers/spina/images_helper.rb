module Spina
  module ImagesHelper

    def thumbnail_url(image)
      return "" if image.nil?
      main_app.url_for(image.variant(resize_to_fill: [400, 300]))
    end

    def embedded_image_url(image)
      return "" if image.nil?

      # support both ImageProcessing gem macro :resize_to_limit and ImageMagick-specific :resize
      resize_key = Spina.config.embedded_image_size.is_a?(Array) ? :resize_to_limit : :resize
      main_app.url_for(image.variant(Hash[resize_key, Spina.config.embedded_image_size]))
    end
    
    def content_type_color(image)
      case content_type(image)
      when "png"
        "bg-green-300"
      when "heic"
        "bg-blue-200"
      when "jpg", "jpeg"
        "bg-blue-400"
      when "gif"
        "bg-indigo-300"
      when "svg"
        "bg-yellow-400"
      else
        "bg-gray-400"
      end
    end
    
    def content_type(image)
      image.file.content_type&.split("/")&.last || I18n.t("spina.images.missing_image")
    end

  end
end
