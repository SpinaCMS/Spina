module Spina
  module Admin
    class MediaFoldersController < AdminController

      def new
        @media_folder = MediaFolder.new
      end

      def create
        @media_folder = MediaFolder.new(media_folder_params)
        @media_folder.save
        redirect_to spina.admin_photos_path
      end

      def destroy
        @media_folder = MediaFolder.find(params[:id])
        @media_folder.destroy
        redirect_to spina.admin_photos_path
      end

      private

        def media_folder_params
          params.require(:media_folder).permit(:name)
        end
    end
  end
end