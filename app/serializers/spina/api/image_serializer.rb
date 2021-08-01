module Spina::Api
  class ImageSerializer < BaseSerializer    
    set_type :image
    
    attributes :id
    
    attribute :url do |image, params|
      params[:view_context].main_app.url_for(image.variant(resize_to_fill: [2000, 2000]))
    end
  end
end
