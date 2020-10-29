module Spina
  module UserInterface
    class ModalComponent < ApplicationComponent
      
      def initialize(size: "max-w-lg")
        @size = size
      end
      
    end
  end
end