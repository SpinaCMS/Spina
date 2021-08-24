module Spina
  class ContentPresenter
    attr_reader :view_context, :container
    
    SPINA_EMBED_SELECTOR = 'figure[data-trix-content-type="application/vnd+spina.shorttag+html"]'

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
      html = render_spina_embeds(html)
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
      view_context.main_app.url_for(attachment) if attachment.present?
    end

    private

      def main_app_image_url(image, variant_options = {})
        # SVG's can't have variants, 
        # Render rails_service_blob_url directly instead
        return view_context.main_app.url_for(image) if image.svg?
        
        view_context.main_app.url_for(image.variant(variant_options))
      end

      def find_part(name)
        container.find_part(name)
      end
      
      def render_spina_embeds(html)
        doc = Nokogiri::HTML(html)
        doc.css(SPINA_EMBED_SELECTOR).each do |shorttag|
          shorttag.replace element_to_html(shorttag.first_element_child)
        end
        doc
      end
      
      def element_to_html(element)
        class_name = element.name.split("-").map(&:capitalize).join("")
        component_name = "Spina::Embeddable::#{class_name}"
        component = component_name.safe_constantize&.new(element.attributes)
        return "Missing component (#{component_name})" unless component
        view_context.render(component)
      end

  end
end