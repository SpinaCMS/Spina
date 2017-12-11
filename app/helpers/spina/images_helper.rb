module Spina
  module ImagesHelper

    def variant(file, options)
      variant = file.variant(options)
      main_app.rails_blob_variation_path(variant.blob.signed_id, variant.variation.key, variant.blob.filename)
    end

  end
end