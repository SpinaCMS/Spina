module Spina
  module Admin
    class PhotosController < AdminController
      before_action :set_breadcrumbs

      layout "spina/admin/media_library"

      def index
        add_breadcrumb I18n.t('spina.website.photos'), spina.admin_photos_path
        @media_folders = MediaFolder.order(:name)
        @photos = Photo.sorted.where(media_folder_id: nil).page(params[:page])
        @photo = Photo.new

        respond_to do |format|
          format.js
          format.html
        end
      end

      def media_folder
        add_breadcrumb I18n.t('spina.website.photos'), spina.admin_photos_path
        @media_folder = MediaFolder.find(params[:id])
        add_breadcrumb @media_folder.name
        @photos = @media_folder.photos.sorted.page(params[:page])

        respond_to do |format|
          format.js { render :index }
          format.html
        end
      end

      def add_to_media_folder
        @media_folder = MediaFolder.find(params[:id])
        @media_folder.photos << Photo.find(params[:photo_id])
        render json: @media_folder
      end

      def media_library
        redirect_to spina.admin_photos_path
      end

      def create
        @photos = photo_params[:files].map do |file|
          Photo.create!(file: file, media_folder_id: photo_params[:media_folder_id])
        end
      end

      def destroy
        @photo = Photo.find(params[:id])
        @photo.destroy
        redirect_back fallback_location: spina.admin_photos_url
      end

      def photo_select
        @selected_photo_id = Photo.find_by(id: params[:selected_photo_id]).try(:id)
        @hidden_field_id = params[:hidden_field_id]
        @photos = Photo.order_by_ids(@selected_photo_id).sorted.page(params[:page])
        @photo = Photo.new

        if params[:page].present?
          render :single_picker_infinite_scroll
        else
          render :photo_select
        end
      end

      def photo_collection_select
        @selected_photo_ids = Photo.where(id: params[:selected_photo_ids]).ids
        @photos = Photo.order_by_ids(@selected_photo_ids).sorted.page(params[:page])
        @photo = Photo.new

        if params[:page].present?
          render :multi_picker_infinite_scroll
        else
          render :photo_collection_select
        end
      end

      def insert_photo
        @photo = Photo.find(params[:photo_id]) if params[:photo_id].present?
      end

      def insert_photo_collection
        @photos = Photo.find(params[:photo_ids]) if params[:photo_ids].present?
      end

      def trix_insert    
        @photo = Photo.find(params[:photo_id])    
      end
 
      def trix_select
        @photos = Photo.sorted.page(params[:page])    
        @photo = Photo.new    
    
        if params[:page].present?   
          render :trix_infinite_scroll   
        else    
          render :trix_select    
        end   
      end

      private

      def set_breadcrumbs
        add_breadcrumb I18n.t('spina.website.media_library'), spina.admin_media_library_path
      end

      def photo_params
        params.require(:photo).permit(:media_folder_id, files: [])
      end

    end
  end
end
