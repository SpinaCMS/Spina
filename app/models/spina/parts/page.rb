module Spina
  module Parts
    class Page < Base
      attr_json :page_id, :integer, default: nil

      def content
        Page.live.find_by(id: page_id)
      end
    end
  end
end
