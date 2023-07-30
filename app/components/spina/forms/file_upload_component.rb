module Spina
  module Forms
    class FileUploadComponent < ApplicationComponent
      attr_reader :css_classes, :id, :origin, :file_field_id, :media_folder, :trix_id, :turbo_frame

      def initialize(origin:, css_classes: '', id: nil, trix_target_id: nil, media_folder: nil, turbo_frame: nil)
        @origin = origin
        @css_classes = css_classes
        @id = id || SecureRandom.uuid
        @media_folder = media_folder
        @trix_target_id = trix_target_id # If inserting an image into Trix, specifies which one receives it
        @turbo_frame = turbo_frame

        @file_field_id = "image_upload_file_field_#{@id}"
      end

    end
  end
end
