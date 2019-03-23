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

      # There's no file validation yet in ActiveStorage
      # We do two things to reduce errors right now:
      # 1. We add accept="image/*" to the image form
      # 2. We destroy the entire record if the uploaded file is not an image
      def create
        @images = params[:image][:files].map do |file|
          # Create the image and attach the file
          image = Image.create
          image.file.attach(file)

          # Was it not an image after all? DESTROY IT
          image.destroy and next unless image.file.image?

          image
        end.compact
      end

      def destroy
        @image = Image.find(params[:id])
        @image.destroy
        redirect_back fallback_location: spina.admin_images_url
      end

      def add_to_media_folder
        @media_folder = MediaFolder.find(params[:id])
        @media_folder.images << Image.find(params[:image_id])
        render json: @media_folder
      end

      private

        def set_breadcrumbs
          add_breadcrumb I18n.t('spina.website.media_library'), admin_media_library_path
        end

    end
  end
end