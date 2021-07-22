module Spina
  module UserInterface
    class HeaderComponent < ApplicationComponent      
      renders_one :actions
      renders_one :navigation
      renders_one :after_breadcrumbs
    end
  end
end