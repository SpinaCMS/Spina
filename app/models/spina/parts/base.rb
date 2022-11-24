module Spina
  module Parts
    class Base
      include AttrJson::Model

      attr_json_config(unknown_key: :strip)

      attr_json :name, :string

      attr_accessor :title, :hint, :item_name

      def label
        content&.to_s
      end

      def content; end
    end
  end
end
