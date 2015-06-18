# encoding: utf-8
module Spina
  class PhotoUploader < Spina::DefaultStoreUploader
    include CarrierWave::MiniMagick

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
