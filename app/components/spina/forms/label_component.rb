module Spina
  module Forms
    class LabelComponent < ApplicationComponent
      attr_reader :f, :method

      def initialize(f, method)
        @f = f
        @method = method
      end

      def call
        f.label method, class: "font-medium text-sm text-gray-700 block"
      end
    end
  end
end
