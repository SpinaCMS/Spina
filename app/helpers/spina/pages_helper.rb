module Spina
  module PagesHelper

    def content(part_name = nil)
      Current.page.content(part_name)
    end

    def has_content?(part_name)
      Current.page.has_content?(part_name)
    end

    def repeater(part)
      part = Current.page.find_part(part)&.content unless part.is_a? Array
      part&.each do |repeater_content|
        repeater_content.view_context = self
        yield(repeater_content)
      end
    end

    def images(part)
      part = Current.page.find_part(part)&.content unless part.is_a? Array
      part&.each do |image|
        yield(image)
      end
    end

    def current_page
      Current.page
    end

    def current_spina_account
      Current.account
    end

  end
end
