module Spina
  module Forms

    # Meant to be a hidden component for facilitating quick file uploads from drag and drop or paste action within Trix
    class AutoFileUploadComponent < ApplicationComponent
      attr_reader :turbo_frame_id

      def initialize
        @turbo_frame_id = "auto-file-upload-images"
      end

    end

  end
end
