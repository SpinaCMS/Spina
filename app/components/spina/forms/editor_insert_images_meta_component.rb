module Spina
  module Forms
    class EditorInsertImagesMetaComponent < ApplicationComponent
      attr_reader :images, :trix_target_id

      def initialize(trix_target_id: nil, images:[])
        @trix_target_id = trix_target_id
        @images = images
      end
    end
  end
end
