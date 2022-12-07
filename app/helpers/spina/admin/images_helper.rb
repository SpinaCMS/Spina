module Spina::Admin
  module ImagesHelper
    def ratio_tailwind_class_for_image_part(image)
      case image.options.try(:[], :ratio)
      when "portrait"
        "w-28"
      when "landscape"
        "w-48"
      when "wide"
        "w-80"
      else
        "w-36" # Square (default)
      end
    end
  end
end
