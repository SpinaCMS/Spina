module Spina
  module Admin
    class PhotosController < AdminController
      before_action :set_breadcrumbs

      authorize_resource class: Photo

      layout "spina/admin/media_library"

      def index
        add_breadcrumb I18n.t('spina.website.photos'), spina.admin_photos_path
        @photos = Photo.sorted.page(params[:page])
        @photo = Photo.new
      end

      def media_library
        redirect_to spina.admin_photos_path
      end

      def create
        if photo_params[:files].present?
          @photos = photo_params[:files].map do |file|
            Photo.create!(file: file)
          end
          respond_to do |format|
            format.js do
              render :create_multiple
            end
          end
        else
          @photo = Photo.create!(photo_params)
          respond_to do |format|
            format.js do
              render params[:media_library] ? :create : :create_and_select
            end
            format.json do
              render json: { file_url: @photo.file_url }
            end
          end
        end
      end

      def destroy
        @photo = Photo.find(params[:id])
        @photo.destroy
        redirect_to spina.admin_photos_url
      end

      def enhance
        @photo = Photo.find(params[:id])
        @photo.remote_file_url = params[:new_image]
        @photo.save
      end

      def link
        @photo = Photo.find(params[:id])
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

      def wysihtml5_insert
        @photo = Photo.find(params[:photo_id])
      end

      def wysihtml5_select
        @photos = Photo.sorted.page(params[:page])
        @photo = Photo.new

        if params[:page].present?
          render :wysihtml5_infinite_scroll
        else
          render :wysihtml5_select
        end
      end

      private

      def set_breadcrumbs
        add_breadcrumb I18n.t('spina.website.media_library'), spina.admin_media_library_path
      end

      def photo_params
        params.require(:photo).permit(:file, files: [])
      end

    end
  end
end
