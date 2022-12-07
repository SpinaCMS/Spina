module Spina
  module MediaPicker
    class ModalComponent < ApplicationComponent
      def initialize(target, images:, media_folder: nil)
        @target = target
        @images = images
        @media_folder = media_folder
      end

      def media_folders
        @media_folders ||= Spina::MediaFolder.order(:name)
      end

      def image_count
        @image_count ||= Spina::Image.count
      end

      def media_folder_classes(media_folder)
        if media_folder == @media_folder
          "text-gray-900 bg-spina-dark bg-opacity-20"
        else
          "text-gray-600 hover:bg-gray-200 bg-opacity-100 hover:bg-gray-200"
        end
      end
    end
  end
end
