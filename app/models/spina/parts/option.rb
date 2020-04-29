module Spina
  module Parts
    class Option < Base
      attr_json :value, :string, default: ""

      def content
        value
      end
    end
  end
end
