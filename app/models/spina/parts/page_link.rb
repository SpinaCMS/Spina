module Spina
  module Parts
    class PageLink < Base
      attr_json :page_id, :integer, default: nil
      attr_json :text, :string, default: nil

      attr_accessor :options

      def content
        ::Spina::Page.live.find_by(id: page_id)
      end
    end
  end
end
