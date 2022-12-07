module Spina
  module Admin
    class MediaFoldersController < AdminController
      def new
        @media_folder = MediaFolder.new
      end

      def edit
        @media_folder = MediaFolder.find(params[:id])
      end

      def create
        @media_folder = MediaFolder.new(media_folder_params)
        if @media_folder.save
          redirect_to spina.admin_images_path
        else
          render turbo_stream: turbo_stream.update(view_context.dom_id(@media_folder, :form), partial: "form")
        end
      end

      def update
        @media_folder = MediaFolder.find(params[:id])
        if @media_folder.update(media_folder_params)
          redirect_to spina.admin_media_folder_images_path(@media_folder)
        else
          render turbo_stream: turbo_stream.update(view_context.dom_id(@media_folder, :form), partial: "form")
        end
      end

      def destroy
        @media_folder = MediaFolder.find(params[:id])
        @media_folder.destroy
        redirect_to spina.admin_images_path
      end

      private

      def media_folder_params
        params.require(:media_folder).permit(:name)
      end
    end
  end
end
