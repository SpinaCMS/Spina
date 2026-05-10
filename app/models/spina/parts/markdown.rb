module Spina
  module Parts
    class Markdown < Base
      attr_json :content, :string, default: ""

      def to_html
        Kramdown::Document.new(content.to_s).to_html.html_safe
      end
    end
  end
end
