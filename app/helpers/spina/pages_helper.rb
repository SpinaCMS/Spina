module Spina
  module PagesHelper

    def content(part_name)
      current_page.get_part(part_name.to_s)&.content
    end

    # def has_content?(part_name)
    #   current_page.has_content?(part_name)
    # end

    def current_page
      Current.page
    end

  end
end