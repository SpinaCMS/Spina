module Spina
  class DefaultStoreUploader < CarrierWave::Uploader::Base

    def store_dir
      case ::Spina.config.storage
      when :s3
        "#{mounted_as}/#{model.class.to_s.underscore}/#{model.id}"
      when :file
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      else
        raise NotImplementedError, "Please set your storage preferences in config/initializers/spina.rb"
      end
    end
  end
end
