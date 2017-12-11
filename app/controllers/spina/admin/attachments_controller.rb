module Spina
  module Admin
    class AttachmentsController < AdminController
      before_action :set_breadcrumbs

      layout "spina/admin/media_library"

      def index
        add_breadcrumb I18n.t('spina.website.documents'), spina.admin_attachments_path
        @attachments = Attachment.sorted
      end

      def create
        @attachments = params[:attachment][:files].map do |file|
          attachment = Attachment.create(attachment_params)
          attachment.file.attach(file)
          attachment
        end
      end

      def destroy
        @attachment = Attachment.find(params[:id])
        @attachment.destroy
        redirect_to spina.admin_attachments_url
      end

      def select
        @attachments = Attachment.sorted
        
        if params[:selected_ids].present?
          ids = params[:selected_attachment_id]
          @attachments = @attachments.order(Arel.sql("CASE WHEN id IN(#{ids}) THEN 0 ELSE 1 END"))
        end
      end

      def insert
        @attachment = Attachment.find(params[:attachment_id])
      end

      def select_collection
        @selected_attachment_ids = Attachment.where(id: params[:selected_attachment_ids]).ids
        @attachments = Attachment.order_by_ids(@selected_attachment_ids).sorted
        @attachment = Attachment.new
      end

      def insert_collection
        @attachments = Attachment.where(id: params[:attachment_ids])
      end

      private

      def set_breadcrumbs
        add_breadcrumb I18n.t('spina.website.media_library'), spina.admin_media_library_path
      end

      def attachment_params
        params.require(:attachment).permit(:file, :page_id, :_destroy)
      end
    end
  end
end
