module Spina
  module UserInterface
    class TabLinkComponent < ApplicationComponent
      def initialize(name = nil, url = nil, active: false)
        url = name if url.nil?
        @url = url
        @name = name
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
