module Spina
  module Parts
    class Base
      include AttrJson::Model

      attr_json_config(unknown_key: :strip)

      attr_json :title, :string
      attr_json :name, :string

      def label
        content&.to_s
      end

      def content; end
    end
  end
end