# encoding: utf-8
module Spina
  class FileUploader < CarrierWave::Uploader::Base

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

  end
end