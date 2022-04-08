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
      RichTextPresenter.new(view_context, html)
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
      view_context.main_app.url_for(attachment) if attachment.present?
    end

    private

      def main_app_image_url(image, variant_options = {})
        # SVG's and animated GIF's can't have variants,
        # Render rails_service_blob_url directly instead
        return view_context.main_app.url_for(image) if image.svg? || image.gif?

        view_context.main_app.url_for(image.variant(variant_options))
      end

      def find_part(name)
        container.find_part(name)
      end

  end
end
