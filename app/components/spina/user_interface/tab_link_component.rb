module Spina
  module UserInterface
    class TabLinkComponent < ApplicationComponent
      
      def initialize(label, path, active: false)
        @label = label
        @path = path
        @active = active
      end
      
      def css_classes
        if @active
          "cursor-default text-gray-900 bg-spina-dark bg-opacity-10"
        else
          ""
        end
      end
      
    end
  end
end