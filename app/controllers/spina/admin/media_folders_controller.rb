module Spina
  module Admin
    class MediaFoldersController < AdminController
      layout "spina/admin/media_library"

      def new
        @media_folder = MediaFolder.new
      end

      def show
        add_breadcrumb I18n.t('spina.website.media_library'), admin_media_library_path
        add_breadcrumb I18n.t('spina.website.images'), spina.admin_images_path
        @media_folder = MediaFolder.find(params[:id])
        add_breadcrumb @media_folder.name
        @images = @media_folder.images.sorted.page(params[:page])
      end

      def create
        @media_folder = MediaFolder.new(media_folder_params)
        @media_folder.save
        redirect_to spina.admin_images_path
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