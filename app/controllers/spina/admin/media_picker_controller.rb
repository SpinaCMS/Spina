module Spina
  module Admin
    class MediaPickerController < AdminController
      before_action :set_media_folders

      def show
        if @media_folder.present?
          @images = @media_folder.images.page(params[:page])
        else
          @images = Image.where(media_folder_id: nil).page(params[:page])
        end

        if params[:selected_ids].present?
          ids = params[:selected_ids].map(&:to_i).join(', ')
          @images = @images.order(Arel.sql("CASE WHEN id IN(#{ids}) THEN 0 ELSE 1 END, created_at DESC"))
        else
          @images = @images.sorted
        end

        render params[:page].present? ? :infinite_scroll : :show
      end

      def select
        if params[:multiple]
          @images = Image.where(id: params[:image_ids].split("-"))
        else 
          @image = Image.find(params[:image_id])
        end
      end

      private

        def set_media_folders
          @media_folders = MediaFolder.order(:name)
          @media_folder = MediaFolder.find(params[:media_folder_id]) if params[:media_folder_id].present?
        end

    end
  end
end
