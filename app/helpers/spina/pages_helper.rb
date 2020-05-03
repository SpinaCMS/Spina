module Spina
  module PagesHelper

    def content(part_name, global: false)
      find_part(part_name, global)&.content
    end

    def spina_image_tag(image, variant_options = {}, options = {})
      image = find_part(image, global: options[:global]) unless image.is_a? Spina::Parts::Image
      return "" unless image
      image_tag_options = {alt: image.alt}
      image_tag spina_image_url(image, variant_options), image_tag_options.merge(options)
    end

    def spina_attachment_url(attachment, global: false)
      attachment = find_part(attachment, global) unless attachment.is_a?(Spina::Parts::Attachment)
      return "" unless attachment
      main_app.rails_service_blob_url(attachment.signed_blob_id, filename: attachment.filename)
    end

    def spina_image_url(image, options = {})
      image = find_part(image, global: options[:global]) unless image.is_a? Spina::Parts::Image
      return "" unless image
      variant_key = ActiveStorage::Variation.encode(options)
      main_app.rails_blob_representation_url(image.signed_blob_id, variant_key, image.filename)
    end

    def repeater(part_name, global: false)
      find_part(part_name, global)&.content&.each do |repeater_content|
        yield(repeater_content)
      end
    end
    alias_method :images, :repeater

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
