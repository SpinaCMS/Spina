module Spina
  class Theme

    attr_accessor :name, :title, :parts, :page_parts, :structures, :view_templates, :layout_parts, :custom_pages, :plugins, :public_theme, :config, :navigations, :resources

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
      @resources        = []
      @public_theme = false
    end

    def new_page_templates(recommended: "")
      @view_templates.map do |view_template|
        next if is_custom_undeletable_page?(view_template[:name])
        
        OpenStruct.new({
          name: view_template[:name],
          title: view_template[:title],
          description: view_template[:description],
          recommended: view_template[:name] == recommended
        })
      end.compact.sort_by do |page_template|
        [page_template.recommended ? 0 : 1]
      end
    end

    # Check if view_template is defined as a custom undeletable page
    def is_custom_undeletable_page?(view_template_name)
      @custom_pages.any? { |page| page[:view_template] == view_template_name && !page[:deletable] }
    end

  end
end
