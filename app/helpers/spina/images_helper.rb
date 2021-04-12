module Spina
  module ImagesHelper

    def thumbnail_url(image)
      return "" if image.nil?
      main_app.url_for(image.variant(resize_to_fill: [400, 300]))
    end

    def embedded_image_url(image)
      return "" if image.nil?

      # support both ImageProcessing gem macro :resize_to_limit and ImageMagick-specific :resize
      resize_key = if !Spina.config.embedded_image_size.is_a?(Array)
                     :resize
                   else
                     :resize_to_limit
                   end
      byebug
      main_app.url_for(image.variant(Hash[resize_key, Spina.config.embedded_image_size]))
    end

  end
end
