# encoding: utf-8
module Spina
  class FileUploader < CarrierWave::Uploader::Base

    def store_dir
      if Engine.config.storage == :s3
        "#{mounted_as}/#{model.id}"
      else
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end

  end
end