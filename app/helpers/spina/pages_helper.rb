module Spina
  module PagesHelper

    def page_content(part_name)
      current_page.content(part_name)
    end

    def page_has_content?(part_name)
      current_page.has_content?(part_name)
    end

    def current_page
      @page
    end

  end
end