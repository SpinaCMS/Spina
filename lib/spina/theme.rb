module Spina
  class Theme

    attr_accessor :name, :title, :page_parts, :structures, :view_templates, :layout_parts, :custom_pages, :plugins, :public_theme, :config

    # deprecate :config

    class << self

      def all
        ::Spina::THEMES
      end

      def find_by_name(name)
        all.find { |theme| theme.name == name }
      end

      def register
        theme = ::Spina::Theme.new
        yield theme
        raise 'Missing theme name' if theme.name.nil?
        all << theme
      end

    end

    def initialize
      @page_parts       = []
      @structures       = {}
      @layout_parts     = []
      @view_templates   = {}
      @custom_pages     = []
      @plugins          = []
      @public_theme = false
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
