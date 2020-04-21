module Spina
  module PagesHelper

    def content(part_name)
      current_page.content(part_name)
    end

    def spina_image_url(image, options = {})
      image = current_page.find_part(image) unless image.is_a?(Spina::Parts::Image)
      return "" unless image
      variant_key = ActiveStorage::Variation.encode(options)
      main_app.rails_blob_representation_url(image.signed_blob_id, variant_key, "image.png")
    end

    def images(part_name)
      current_page.find_part(part_name)&.images&.each do |image| 
        yield(image)
      end
    end

    def repeater(part_name)
      current_page.find_part(part_name)&.content&.each do |repeater_content|
        yield(repeater_content)
      end
    end

    def has_content?(part_name)
      current_page.has_content?(part_name)
    end

    def current_page
      Current.page
    end

  end
end