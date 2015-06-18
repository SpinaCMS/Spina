# encoding: utf-8
module Spina
  class LogoUploader < Spina::DefaultStoreUploader
    include CarrierWave::MiniMagick

    process resize_to_fit: [300, 300]

    def extension_white_list
      %w(jpg jpeg gif png)
    end

  end
end