module Spina
  class RichTextPresenter
    attr_reader :html, :view_context
    
    EMBED_CONTENT_TYPE = "application/vnd+spina.embed+html"
    
    def initialize(view_context, html)
      @view_context = view_context || Spina::Current.page&.view_context
      @html = html
    end
    
    def to_s
      ActiveSupport::SafeBuffer.new(render_embeds(html))
    end
    
    private
    
      def embed_selector
        "figure[data-trix-content-type=\"#{EMBED_CONTENT_TYPE}\"]"
      end
    
      def render_embeds(html)
        doc = Nokogiri::HTML(html)
        doc.css(embed_selector).each do |node|
          node.replace render_embed(node.first_element_child)
        end
        doc.to_s
      end
      
      def render_embed(element)
        embeddable = element_to_embeddable(element)
        view_context.render(embeddable)
      end
      
      def element_to_embeddable(element)
        embeddable = Spina::Embeds.constantize(element["data-embed-type"])
        embeddable&.from_json(element["data-embed-attributes"]) || null_object
      end
      
      def null_object
        {inline: ""}
      end

  end
end