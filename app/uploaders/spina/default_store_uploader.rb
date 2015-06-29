module Spina
  class DefaultStoreUploader < CarrierWave::Uploader::Base

    def store_dir
      if Engine.config.try(:storage) == :s3
        "#{mounted_as}/#{model.class.to_s.underscore}/#{model.id}"
      else
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
end