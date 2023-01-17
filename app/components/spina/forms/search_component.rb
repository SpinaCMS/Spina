module Spina
  module Forms
    class SearchComponent < ApplicationComponent
      attr_accessor :f, :method

      def initialize(f, method)
        @f = f
        @method = method
      end
    end
  end
end
