module Spina
  module PagesHelper

    def page_content(part_name)
      page.content(part_name)
    end

    def page_has_content?(part_name)
      page.has_content?(part_name)
    end

    def current_page
      Current.page
    end

  end
end