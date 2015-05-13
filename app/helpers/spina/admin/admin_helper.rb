module Spina
  module Admin
    module AdminHelper

      def icon(name)
        content_tag(:i, nil, class: "icon icon-#{name}")
      end

    end
  end
end
