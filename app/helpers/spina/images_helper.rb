module Spina
  module ImagesHelper

    def thumbnail_url(image)
      return "" if image.nil?
      main_app.url_for(image.variant(resize_to_fill: [400, 300]))
    end

    def embedded_image_url(image)
      return "" if image.nil?
      main_app.url_for(image.variant(resize_to_limit: Spina.config.embedded_image_size))
    end

  end
end
