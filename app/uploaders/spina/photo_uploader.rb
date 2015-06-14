# encoding: utf-8
module Spina
  class PhotoUploader < CarrierWave::Uploader::Base

    include CarrierWave::MiniMagick

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    version :image do
      process resize_to_fit: [800, 800], if: :too_large?
    end

    version :thumb do
      process resize_to_fill: [240, 135]
    end

    def too_large?(new_file)
      new_file.size > 120 * 1000
    end

    def extension_white_list
      %w(jpg jpeg gif png)
    end

  end
end
