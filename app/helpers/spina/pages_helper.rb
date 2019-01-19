module Spina
  module PagesHelper

    def content(part_name)
      current_page.content(part_name)
    end

    def has_content?(part_name)
      current_page.has_content?(part_name)
    end

    def spina_image_tag(image_id, variant_options = {})
      image = Spina::Image.find_by(id: image_id)
      image_tag(main_app.url_for(image.variant(variant_options)))
    end

    def current_page
      Current.page
    end

  end
end