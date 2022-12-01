module Spina
  module Admin
    class MediaPickerController < AdminController
      def show
        @images = Spina::Image.sorted.with_attached_file.page(params[:page]).per(16)

        if (@media_folder = Spina::MediaFolder.find_by(id: params[:media_folder_id]))
          @images = @images.where(media_folder: @media_folder)
        end
      end
    end
  end
end
