module Spina
  module Pages
    class TabButtonComponent < ApplicationComponent
      renders_one :label, "LabelComponent"

      def initialize(tab_name:)
        @tab_name = tab_name
      end

      class LabelComponent < ApplicationComponent
        def call
          content
        end
      end
    end
  end
end