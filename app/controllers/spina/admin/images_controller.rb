module Spina
  module Admin
    class ImagesController < AdminController
      before_action :set_media_folder
      before_action :set_breadcrumbs

      def index
        @media_folders = MediaFolder.order(:name)
        @images = Image.sorted.where(media_folder: @media_folder).with_attached_file.page(params[:page]).per(25)
      end
      
      def edit
        @image = Image.find(params[:id])
      end

      # There's no file validation yet in ActiveStorage
      # We do two things to reduce errors right now:
      # 1. We add accept="image/*" to the image form
      # 2. We destroy the entire record if the uploaded file is not an image
      def create
        @images = params[:image][:files].map do |file|
          # Create the image and attach the file
          image = Image.create(media_folder_id: image_params[:media_folder_id])
          image.file.attach(file)

          # Was it not an image after all? DESTROY IT
          image.destroy and next unless image.file.image?

          image
        end.compact
        
        if params[:modal]
          redirect_to spina.admin_media_picker_path(media_folder_id: image_params[:media_folder_id])
        else
          render turbo_stream: turbo_stream.prepend("images", partial: "image", collection: @images)
        end
      end
      
      def update
        @image = Image.find(params[:id])
        @image.update(image_params) if params[:image].present?
        if params[:filename].present?
          extension = @image.file.filename.extension
          filename = "#{params[:filename]}.#{extension}"
          @image.file.blob.update(filename: filename)
        end
        if @image.saved_change_to_media_folder_id?
          render :update
        else
          render @image
        end
      end

      def destroy
        @image = Image.find(params[:id])
        @image.destroy
        render turbo_stream: turbo_stream.remove(@image)
      end

      private

        def set_breadcrumbs
          if @media_folder.present?
            add_breadcrumb I18n.t('spina.website.media_library'), admin_images_path, class: 'text-gray-400'
            add_breadcrumb @media_folder.name
          else
            add_breadcrumb I18n.t('spina.website.media_library')
          end
        end
        
        def set_media_folder
          if params[:media_folder_id].present?
            @media_folder = MediaFolder.find(params[:media_folder_id])
          end
        end
        
        def image_params
          params.require(:image).permit(:media_folder_id)
        end

    end
  end
end