module Spina
  module Parts
    class PageLink < Base
      attr_json :page_id, :integer, default: nil
      
      attr_accessor :options

      def content
        Page.live.find_by(id: page_id)
      end
    end
  end
end
