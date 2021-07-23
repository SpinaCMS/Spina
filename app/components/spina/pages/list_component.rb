module Spina
  module Pages
    class ListComponent < ApplicationComponent
      attr_reader :depth, :sortable
  
      def initialize(pages:, sortable: true)
        @pages = pages
        @sortable = sortable
      end
  
    end
  end
end