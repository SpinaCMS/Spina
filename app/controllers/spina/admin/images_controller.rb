module Spina
  module Admin
    class ImagesController < AdminController
      before_action :set_breadcrumbs

      layout "spina/admin/media_library"

      def index
        add_breadcrumb I18n.t('spina.website.images'), admin_images_path
        @media_folders = MediaFolder.order(:name)
        @images = Image.sorted.where(media_folder_id: nil).with_attached_file.page(params[:page])
      end

      def create
        @images = params[:image][:files].map do |file|
          image = Image.create
          image.file.attach(file)
          image
        end
      end

      def destroy
        @image = Image.find(params[:id])
        @image.destroy
        redirect_back fallback_location: spina.admin_images_url
      end

      private

        def set_breadcrumbs
          add_breadcrumb I18n.t('spina.website.media_library'), admin_media_library_path
        end

    end
  end
end