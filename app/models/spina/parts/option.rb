module Spina
  module Parts
    class Option < Base
      attr_json :value, :string, default: ""

      attr_accessor :options

      def content
        value
      end
    end
  end
end
