module Spina
  module UserInterface
    class HeaderComponent < ApplicationComponent
      include ViewComponent::SlotableV2
      
      renders_one :actions
      renders_one :navigation
      renders_one :after_breadcrumbs
    end
  end
end