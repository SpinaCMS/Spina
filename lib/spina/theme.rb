module Spina
  class Theme

    attr_accessor :name, :config

    def to_s
      name
    end

    def new_page_templates
      config.view_templates.map do |view_template|
        [view_template[0], view_template[1][:title], view_template[1][:description], view_template[1][:usage]] unless is_custom_undeletable_page?(view_template[0])
      end.compact
    end

    # Check if view_template is defined as a custom undeletable page
    def is_custom_undeletable_page?(view_template)
      config.custom_pages.any? { |page| page[:view_template] == view_template && !page[:deletable] }
    end
  end
end
