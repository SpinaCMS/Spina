module Spina
  module Forms
    class SwitchComponent < ApplicationComponent
      attr_accessor :f, :method, :selected
      
      # ADDITION
      # allow selection state to be passed in
      def initialize(f, method, selected: false)
        @f = f
        @method = method
        @selected =
          case method.class
          when FalseClass
            false
          when TrueClass
            true
          else
            selected
          end
      end
    end
  end
end
