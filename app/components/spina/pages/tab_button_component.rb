module Spina
  module Pages
    class TabButtonComponent < ApplicationComponent
      include ViewComponent::SlotableV2
      renders_one :icon, "IconComponent"

      def initialize(tab_name:, shortened_text_for_mobile: nil)
        @tab_name = tab_name
        @shortened_text_for_mobile = shortened_text_for_mobile
      end

      def text_class
        if @shortened_text_for_mobile
          "hidden md:inline"
        end
      end

      class IconComponent < ApplicationComponent
        def call
          content
        end
      end
    end
  end
end