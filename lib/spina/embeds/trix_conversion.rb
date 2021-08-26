module Spina
  module Embeds
    module TrixConversion
      extend ActiveSupport::Concern
      
      # Wrap rendered partial in an <embed> tag for Trix
      def to_trix_attachment(content = trix_attachment_content)        
        wrap_with_embed_tag(content)
      end
      
      def wrap_with_embed_tag(html)
        <<-HTML
          <spina-embed data-embed-type="#{self.class.name}">
            #{html}
          </spina-embed>
        HTML
      end
      
      private
      
        def trix_attachment_content
          ApplicationController.render(partial: to_trix_partial_path, formats: :html, object: self, as: model_name.element)
        end
      
    end
  end
end