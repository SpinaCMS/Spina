module Spina
  class ImageBlobReplaceJob < ApplicationJob
    queue_as { Spina.config.queues[:page_updates] }
  
    def perform(old_signed_id, new_signed_id)
      return if old_signed_id.blank? || new_signed_id.blank?
      pages = get_pages(old_signed_id)
      pages.update_all("json_attributes = regexp_replace(json_attributes::text, '#{old_signed_id}', '#{new_signed_id}')::jsonb")
    end
    
    private
    
      def get_pages(signed_id)
        return Spina::Page.none unless signed_id.present?
        Spina::Page.where("json_attributes::text LIKE ?", "%#{signed_id}%")
      end
    
  end
end
