module Spina
  class Theme

    attr_accessor :name, :title, :parts, :page_parts, :structures, :view_templates, :layout_parts, :custom_pages, :plugins, :public_theme, :config, :navigations, :resources, :embeds

    class << self

      def all
        ::Spina::THEMES
      end
      
      def unregister(name)
        theme = find_by_name(name)
        all.delete(theme) if theme
      end

      def find_by_name(name)
        all.find { |theme| theme.name == name }
      end

      def register
        theme = ::Spina::Theme.new
        yield theme
        raise 'Missing theme name' if theme.name.nil?
        unregister(theme.name)
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
      @embeds           = []
      @public_theme = false
    end
    
    def embeddables
      embeds.map{|embed| Embeds.constantize(embed)}
    end

    # REFACTOR
    # remove chaining map blocks in favor of array collection
    def new_page_templates(resource: nil)
      page_collection = resource&.name || 'main'

      collection = []

      @view_templates.map do |view_template|
        # DEPRECIATE!
        # it doesn't matter if a view template is un-deleteable, it can still be used to make new pages.
        # next if is_custom_undeletable_page?(view_template[:name])
        next if view_template[:exclude_from]&.include?(page_collection)
        
        collection <<
          OpenStruct.new({
            name: view_template[:name],
            title: view_template[:title],
            description: view_template[:description],
            recommended: view_template[:name] == resource&.view_template
          })
      end

      collection.compact.sort_by { |c| c.recommended ? 0 : 1 }
    end

    # DEPRECIATE!
    # # Check if view_template is defined as a custom undeletable page
    # def is_custom_undeletable_page?(view_template_name)
    #   @custom_pages.any? { |page| page[:view_template] == view_template_name && !page[:deletable] }
    # end

  end
end
