module Spina
  class Theme
    attr_accessor :name, :title, :parts, :page_parts, :structures, :view_templates, :layout_parts, :layout_part_definitions, :page_template_definitions, :custom_pages, :plugins, :public_theme, :config, :navigations, :resources, :embeds, :templates_path

    NewPageTemplate = Struct.new(:name, :title, :description, :recommended)

    class << self
      def all
        ::Spina::THEMES
      end

      def unregister(name)
        theme = find_by_name(name)
        all.delete(theme) if theme
        PageTemplate.clear_for_theme(name)
        LayoutParts.clear_for_theme(name)
      end

      def find_by_name(name)
        all.find { |theme| theme.name == name }
      end

      def register
        theme = ::Spina::Theme.new
        yield theme
        raise "Missing theme name" if theme.name.nil?
        unregister(theme.name)
        theme.load_page_templates!
        if theme.plugins.nil?
          theme.plugins = ::Spina::Plugin.all.map { |plugin| plugin.name }
        end
        all << theme
      end

      def legacy_theme_warnings
        @legacy_theme_warnings ||= Set.new
      end
    end

    def initialize
      @page_parts = []
      @structures = []
      @layout_parts = []
      @view_templates = []
      @page_template_definitions = {}
      @custom_pages = []
      @navigations = []
      @resources = []
      @embeds = []
      @public_theme = false
    end

    def embeddables
      embeds.map { |embed| Embeds.constantize(embed) }
    end

    def new_page_templates(resource: nil)
      page_collection = resource&.name || "main"
      @view_templates.map do |view_template|
        next if is_custom_undeletable_page?(view_template[:name])
        next if view_template[:exclude_from]&.include?(page_collection)

        NewPageTemplate.new(
          view_template[:name],
          view_template[:title],
          view_template[:description],
          view_template[:name] == resource&.view_template
        )
      end.compact.sort_by do |page_template|
        [page_template.recommended ? 0 : 1]
      end
    end

    # Check if view_template is defined as a custom undeletable page
    def is_custom_undeletable_page?(view_template_name)
      @custom_pages.any? { |page| page[:view_template] == view_template_name && !page[:deletable] }
    end

    def load_templates_from(path = nil)
      @templates_path = path if path
      @templates_path
    end

    def load_page_templates!
      path = @templates_path || default_templates_path
      ignore_templates_path!(path)
      PageTemplateLoader.load(path, theme_name: name)

      page_templates = PageTemplate.for_theme(name)
      layout_parts_definition = LayoutParts.for_theme(name)

      if page_templates.empty? && layout_parts_definition.nil?
        @page_template_definitions = {}
        warn_legacy_theme_config! if legacy_parts_config?
        return
      end

      if legacy_parts_config?
        raise ArgumentError, legacy_and_template_files_conflict_message(path)
      end

      compiled = PageTemplatesCompiler.new(page_templates, layout_parts: layout_parts_definition)
      @parts = []
      @page_template_definitions = page_templates.to_h { |template| [template.name, template.part_definitions] }
      @layout_part_definitions = compiled.layout_part_definitions
      @view_templates = compiled.view_templates
      @layout_parts = compiled.layout_part_names if compiled.layout_part_names.any?
    end

    def part_definitions_for(context, view_template: nil)
      case context
      when :layout
        layout_part_definitions.presence || parts
      else
        if uses_page_templates? && view_template.present?
          page_template_definitions(view_template)
        else
          parts
        end
      end
    end

    def uses_page_templates?
      @page_template_definitions.present?
    end

    def page_template_definitions(view_template)
      @page_template_definitions[view_template.to_s] || []
    end

    private

    def warn_legacy_theme_config!
      return if Theme.legacy_theme_warnings.include?(name)

      Theme.legacy_theme_warnings << name

      Spina.deprecator.warn(<<~MESSAGE.squish)
        Defining theme.parts and theme.view_templates in config/initializers/themes/#{name}.rb is deprecated
        and will be removed in a future major version of Spina. Move page part definitions to
        #{default_templates_path}/*.rb using PageTemplate.define, and global layout parts to
        #{default_templates_path}/layout.rb using LayoutParts.define.
        Run `bin/rails spina:theme:migrate_templates[#{name}]` to migrate automatically.
      MESSAGE
    end

    def legacy_and_template_files_conflict_message(templates_path)
      <<~MESSAGE
        Theme #{name.inspect} uses both the legacy theme configuration and page template files.

        Remove `theme.parts` and `theme.view_templates` from config/initializers/themes/#{name}.rb.
        Part definitions belong in #{templates_path}/ (PageTemplate.define and LayoutParts.define).

        Run `bin/rails spina:theme:migrate_templates[#{name}]` to migrate automatically.
        Your original initializer will be backed up to #{ThemeMigrator.initializer_backup_path(name)}.
      MESSAGE
    end

    def default_templates_path
      "app/templates/spina/#{name}"
    end

    def ignore_templates_path!(path)
      return unless defined?(Rails) && Rails.application

      absolute_path = Rails.root.join(path)
      Rails.autoloaders.main.ignore(absolute_path) if absolute_path.directory?
    end

    def legacy_parts_config?
      parts.present? || view_templates.present?
    end
  end
end
