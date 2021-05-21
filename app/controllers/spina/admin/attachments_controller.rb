module Spina
  module Admin
    class AttachmentsController < AdminController
      before_action :set_breadcrumbs

      def index
        @attachments = Attachment.sorted.with_attached_file.page(params[:page]).per(25)
      end
      
      def edit
        @attachment = Attachment.find(params[:id])
      end

      def create
        @attachments = params[:attachment][:files].map do |file|
          attachment = Attachment.create(attachment_params)
          attachment.file.attach(file)
          attachment
        end
        
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.prepend("attachments", partial: "attachment", collection: @attachments)}
          format.html { redirect_to spina.admin_attachments_url }
        end
      end
      
      def update
        @attachment = Attachment.find(params[:id])
        if params[:filename].present?
          extension = @attachment.file.filename.extension
          filename = "#{params[:filename]}.#{extension}"
          @attachment.file.blob.update(filename: filename)
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
