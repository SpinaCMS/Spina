module Spina
  module UserInterface
    class DropdownButtonComponent < ApplicationComponent
      attr_reader :disabled
      
      def initialize(disabled: false)
        @disabled = disabled
      end
      
      def call
        content_tag :button, content, {class: classes, type: :submit, disabled: disabled}
      end
      
      def classes
        if disabled
          "block w-full text-left px-3 py-2 text-sm leading-4 text-gray-400 font-medium cursor-default"
        else
          "block w-full text-left px-3 py-2 text-sm leading-4 text-gray-700 hover:bg-gray-100 hover:text-gray-900 font-medium"
        end
      end
    end
  end
end