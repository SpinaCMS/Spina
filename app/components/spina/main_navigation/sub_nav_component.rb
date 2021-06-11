module Spina
  module MainNavigation
    class SubNavComponent < ApplicationComponent      
      renders_one :icon
      renders_one :links
      
      def initialize(name = :content)
        @name = name
      end
      
      def active?
        helpers.admin_section == @name
      end
      
      def button_classes
        if active?
          "opacity-100"
        else
          "opacity-50"
        end
      end
      
      def ul_classes
        if active?
          "md:translate-x-20 "
        else
          "translate-x-full"
        end
      end
      
    end
  end
end