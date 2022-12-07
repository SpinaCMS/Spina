module Spina
  module UserInterface
    class DropdownComponent < ApplicationComponent
      renders_one :button, "ButtonComponent"

      renders_one :menu, "MenuComponent"

      class ButtonComponent < ApplicationComponent
        attr_reader :classes

        def initialize(classes:)
          @classes = classes
        end

        def call
          content_tag :button, content, {type: "button", class: classes, data: {action: "reveal#toggle"}}
        end
      end

      class MenuComponent < ApplicationComponent
        def call
          content_tag :div, content, {class: "origin-top-right absolute right-0 mt-2 w-56 rounded-md shadow-lg border border-gray-200 z-20 rounded-md bg-white shadow-xs py-1", hidden: true, data: {reveal: true, transition: true}}
        end
      end
    end
  end
end
