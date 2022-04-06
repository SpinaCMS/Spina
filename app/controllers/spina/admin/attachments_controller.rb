module Spina
  module Admin
    class AttachmentsController < AdminController
      before_action :set_breadcrumbs

      def index
        @attachments = Attachment.sorted.with_attached_file.page(params[:page]).per(25)
      end
      
      def show
        @attachment = Attachment.find(params[:id])
      end
      
      def edit
        @attachment = Attachment.find(params[:id])
      end

      def create
        @attachments = params[:attachment][:files].map do |file|
          next if file.blank? # Skip the blank string posted by the hidden files[] field
          
          attachment = Attachment.create(attachment_params)
          attachment.file.attach(file)
          attachment
        end.compact
        
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.prepend("attachments", partial: "attachment", collection: @attachments)}
          format.html { redirect_to spina.admin_attachments_url }
        end
      end
      
      def update
        @attachment = Attachment.find(params[:id])
        old_signed_id = @attachment.file&.blob&.signed_id
        @attachment.update(attachment_params) if params[:attachment].present?
        if params[:filename].present?
          extension = @attachment.file.filename.extension
          filename = "#{params[:filename]}.#{extension}"
          @attachment.file.blob.update(filename: filename)
        end

        # Replace all occurrences of the old signed blob ID 
        # with the new ID in a background job
        if @attachment.reload.file&.blob&.signed_id != old_signed_id
          Spina::ReplaceSignedIdJob.perform_later(old_signed_id, @attachment.file&.blob&.signed_id)
        end
                
        render @attachment
      end

      def destroy
        @attachment = Attachment.find(params[:id])
        @attachment.destroy
        render turbo_stream: turbo_stream.remove(@attachment)
      end

      private

      def set_breadcrumbs
        add_breadcrumb I18n.t('spina.website.media_library')
      end

      def attachment_params
        params.require(:attachment).permit(:file, :page_id, :_destroy)
      end
    end
  end
end
