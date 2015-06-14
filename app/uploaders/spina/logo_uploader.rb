# encoding: utf-8

module Spina
  class LogoUploader < CarrierWave::Uploader::Base

    include CarrierWave::MiniMagick

    def store_dir
      if Engine.config.storage == :s3
        "#{mounted_as}/#{model.id}"
      else
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end

    process resize_to_fit: [300, 300]

    def extension_white_list
      %w(jpg jpeg gif png)
    end

  end
end