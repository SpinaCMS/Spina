module Spina
  class ContentPresenter
    attr_reader :view_context, :container

    def initialize(view_context, container)
      @view_context = view_context || Spina::Current.page&.view_context
      @container = container
    end

    def text(name)
      part = find_part(name)
      part&.content.to_s
    end

    def html(name)
      html = find_part(name)&.content
      ActiveSupport::SafeBuffer.new(html.to_s)
    end

    def image_tag(image, variant_options = {}, options = {})
      image = find_part(image) unless image.is_a? Spina::Parts::Image
      image_tag_options = {alt: image&.alt}
      view_context.image_tag main_app_image_url(image, variant_options), options.merge(image_tag_options) if image.present?
    end

    def image_url(image, variant_options = {})
      image = find_part(image) unless image.is_a? Spina::Parts::Image
      main_app_image_url(image, variant_options) if image.present?
    end

    def attachment_url(attachment)
      attachment = find_part(attachment) unless attachment.is_a? Spina::Parts::Attachment
      view_context.main_app.rails_service_blob_url(attachment.signed_blob_id, filename: attachment.filename) if attachment.present?
    end

    private

      def main_app_image_url(image, variant_options = {})
        variant_key = ActiveStorage::Variation.encode(variant_options)
        view_context.main_app.rails_blob_representation_url(image.signed_blob_id, variant_key, image.filename)
      end

      def find_part(name)
        container.find_part(name)
      end

  end
end