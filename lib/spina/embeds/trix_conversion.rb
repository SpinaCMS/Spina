module Spina
  module Embeds
    module TrixConversion
      extend ActiveSupport::Concern
      
      # Wrap rendered partial in an <embed> tag for Trix
      def to_trix_attachment(content = trix_attachment_content)        
        wrap_with_embed_tag(content)
      end
      
      def wrap_with_embed_tag(html)        
        element = html_document.create_element("spina-embed", trix_attachment_attributes)
        element.inner_html = html
        element.to_html
      end
      
      private
      
        def trix_attachment_attributes
          attrs = {"data-embed-type": self.class.name}
          self.class.embed_attributes.each do |attr|
            attrs["data-#{attr.to_s.dasherize}"] = send(attr)
          end
          attrs
        end
      
        def trix_attachment_content
          ApplicationController.render(partial: to_trix_partial_path, formats: :html, object: self, as: model_name.element)
        end
        
        def html_document
          Nokogiri::HTML::Document.new.tap{|doc| doc.encoding = "UTF-8"}
        end
      
    end
  end
end