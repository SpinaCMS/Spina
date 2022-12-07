module Spina
  module Forms
    class SwitchComponent < ApplicationComponent
      attr_accessor :f, :method

      def initialize(f, method)
        @f = f
        @method = method
      end
    end
  end
end
