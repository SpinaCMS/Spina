module Spina
  class RichTextPresenter
    attr_reader :html, :view_context
    
    COMPONENT_CONTENT_TYPE = "application/vnd+spina.component+html"
    COMPONENT_NAMESPACE    = "Spina::Embeddable"
    
    def initialize(view_context, html)
      @view_context = view_context || Spina::Current.page&.view_context
      @html = html
    end
    
    def to_s
      ActiveSupport::SafeBuffer.new(render_components(html))
    end
    
    private
    
      def component_selector
        "figure[data-trix-content-type=\"#{COMPONENT_CONTENT_TYPE}\"]"
      end
    
      def render_components(html)
        doc = Nokogiri::HTML(html)
        doc.css(component_selector).each do |node|
          node.replace render_component(node.first_element_child)
        end
        doc.to_s
      end
      
      def render_component(element)
        component = element_to_component(element)
        view_context.render component
      end
      
      def element_to_component(element)
        name = element.name.split("-").map(&:capitalize).join("")
        class_name = [COMPONENT_NAMESPACE, name].join("::")
        begin
          class_name.constantize.new(element.attributes)
        rescue
          Rails.logger.error "Error: Couldn't find #{class_name}"
          {inline: ""}
        end
      end

  end
end