module Spina
  class Theme

    @@themes = []

    attr_reader :name, :title, :page_parts, :view_templates, :layout_parts, :custom_pages, :plugins, :structures

    class << self

      def all
        @@themes
      end

      def register(theme)
        @@themes << theme
      end

      def find_by_name(name)
        @@themes.find { |theme| theme.name == name }
      end

    end

    def initialize(args)
      args.each { |k,v| instance_variable_set("@#{k}", v) }
      @page_parts         ||= []
      @structures         ||= {}
      @layout_parts       ||= {}
      @view_templates     ||= {}
      @custom_pages       ||= []
      @plugins            ||= []
    end

    def new_page_templates
      @view_templates.map do |view_template|
        [view_template[0], view_template[1][:title], view_template[1][:description], view_template[1][:usage]] unless is_custom_undeletable_page?(view_template[0])
      end.compact
    end

    # Check if view_template is defined as a custom undeletable page
    def is_custom_undeletable_page?(view_template)
      @custom_pages.any? { |page| page[:view_template] == view_template && !page[:deletable] }
    end
  end
end
