module Spina
  module PagesHelper

    def content(part_name, global: false)
      find_part(part_name, global)&.content
    end

    def spina_attachment_url(attachment, global: false)
      attachment = find_part(attachment, global) unless attachment.is_a?(Spina::Parts::Attachment)
      return "" unless attachment
      main_app.rails_service_blob_url(attachment.signed_blob_id, filename: attachment.filename)
    end

    def spina_image_url(image, options = {})
      image = find_part(image, options[:global]) unless image.is_a?(Spina::Parts::Image)
      return "" unless image
      variant_key = ActiveStorage::Variation.encode(options)
      main_app.rails_blob_representation_url(image.signed_blob_id, variant_key, image.filename)
    end

    def images(part_name, global: false)
      find_part(part_name, global)&.images&.each do |image| 
        yield(image)
      end
    end

    def repeater(part_name, global: false)
      find_part(part_name, global)&.content&.each do |repeater_content|
        yield(repeater_content)
      end
    end

    def has_content?(part_name, global: false)
      current_page.has_content?(part_name)
    end

    def current_page
      Current.page
    end

    def current_account
      Current.account
    end

    private

      def find_part(part_name, global = false)
        return Current.account.find_part(part_name) if global
        Current.page.find_part(part_name) || Current.account.find_part(part_name)
      end

  end
end