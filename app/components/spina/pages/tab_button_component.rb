module Spina
  module Pages
    class TabButtonComponent < ApplicationComponent
      include ViewComponent::SlotableV2
      renders_one :content, "ContentComponent"

      def initialize(tab_name:)
        @tab_name = tab_name
      end

      class ContentComponent < ApplicationComponent
        def call
          content
        end
      end
    end
  end
end