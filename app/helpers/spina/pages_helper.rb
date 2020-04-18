module Spina
  module PagesHelper

    def content(part_name)
      current_page.content(part_name)
    end

    def repeater(part_name)
      current_page.find_part(part_name)&.content&.each do |repeater_content|
        yield(repeater_content)
      end
    end

    def has_content?(part_name)
      current_page.has_content?(part_name)
    end

    def current_page
      Current.page
    end

  end
end