module Spina
  module UserInterface
    class ToggleComponent < ApplicationComponent
      def initialize(conditional:, label:, button_color: "!bg-[#6865b4]")
        @button_color = button_color
        @conditional = conditional
        @label = label
      end
    end
  end
end
