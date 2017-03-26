module Spina
  class Theme

    attr_accessor :name, :title, :page_parts, :structures, :view_templates, :layout_parts, :custom_pages, :plugins, :public_theme, :config, :navigations

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
        if theme.plugins.nil?
          theme.plugins = ::Spina::Plugin.all.map { |plugin| plugin.name }
        end
        all << theme
      end

    end

    def initialize
      @page_parts       = []
      @structures       = []
      @layout_parts     = []
      @view_templates   = []
      @custom_pages     = []
      @navigations      = []
      @public_theme = false
    end

    def new_page_templates
      @view_templates.map do |view_template|
        [view_template[:name], view_template[:title], view_template[:description], view_template[:usage]] unless is_custom_undeletable_page?(view_template[:name])
      end.compact
    end

    # Check if view_template is defined as a custom undeletable page
    def is_custom_undeletable_page?(view_template)
      @custom_pages.any? { |page| page[:view_template] == view_template && !page[:deletable] }
    end

  end
end
