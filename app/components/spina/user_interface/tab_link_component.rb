module Spina
  module UserInterface
    class TabLinkComponent < ApplicationComponent
      
      def initialize(url, options = {})
        @url = url
        @active = options[:active]
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
