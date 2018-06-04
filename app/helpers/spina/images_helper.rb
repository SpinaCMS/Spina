module Spina
  module ImagesHelper

    # We wrap some Rails logic inside our own helper method
    # because the resolve directive in ActiveStorage's routes
    # doesn't work outside the main app in 5.2.0.rc2
    def variant(image, options)
      if image.attached?
        variant = image.variant(options)
        main_app.rails_blob_representation_path(variant.blob.signed_id, variant.variation.key, variant.blob.filename)
      else
        "https://placehold.it/100x100.png"
      end
    end

  end
end
