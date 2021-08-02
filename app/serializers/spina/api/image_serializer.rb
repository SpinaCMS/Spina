module Spina::Api
  class ImageSerializer < BaseSerializer    
    set_type :image
    
    attributes :id
    
    attribute :original_url do |image, params|
      params[:view_context].main_app.url_for(image.file)
    end
    
    attribute :thumbnail_url do |image, params|
      params[:view_context].main_app.url_for(image.variant(resize_to_fill: Spina.config.thumbnail_image_size))
    end
    
    attribute :embedded_image_size_url do |image, params|
      resize_key = Spina.config.embedded_image_size.is_a?(Array) ? :resize_to_limit : :resize
      params[:view_context].main_app.url_for(image.variant(Hash[resize_key, Spina.config.embedded_image_size]))
    end
  end
end
