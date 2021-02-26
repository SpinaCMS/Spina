module Spina
  module ImagesHelper

    def thumbnail_url(image)
      return "" if image.nil?
      main_app.url_for(image.variant(resize: "400x300^", crop: "400x300+0+0"))
    end

    def embedded_image_url(image)
      return "" if image.nil?
      main_app.url_for(image.variant(resize: Spina.config.embedded_image_size))
    end

  end
end
