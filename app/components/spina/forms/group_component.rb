module Spina
  module Forms
    class GroupComponent < ApplicationComponent
      attr_reader :label, :description
      
      def initialize(label:, description: "")
        @label = label
        @description = description
      end
      
    end
  end
end