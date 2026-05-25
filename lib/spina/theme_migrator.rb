module Spina
  class ThemeMigrator
    INITIALIZER_BACKUP_EXTENSION = ".rb.bak"

    def self.initializer_backup_path(theme_name, root: nil)
      relative = "config/initializers/themes/#{theme_name}#{INITIALIZER_BACKUP_EXTENSION}"
      root ? root.join(relative) : relative
    end

    def initialize(theme)
      @theme = theme
      @parts_by_name = theme.parts.index_by { |part| part[:name].to_s }
    end

    def migrate_to(output_dir = nil)
      output_path = Rails.root.join(output_dir || templates_path)
      FileUtils.mkdir_p(output_path)

      write_layout_file(output_path) if @theme.layout_parts.present?

      @theme.view_templates.each do |view_template|
        write_template_file(output_path, view_template)
      end

      output_path
    end

    def templates_path
      "app/templates/spina/#{@theme.name}"
    end

    def slim_initializer_content
      lines = []
      lines << "# frozen_string_literal: true"
      lines << ""
      lines << "Spina::Theme.register do |theme|"
      lines << "  theme.name = #{@theme.name.inspect}"
      lines << "  theme.title = #{@theme.title.inspect}"
      lines << "  theme.load_templates_from #{templates_path.inspect}"
      lines << "  # Global layout parts are defined in #{templates_path}/layout.rb"
      lines << ""

      append_hash_array_assignment(lines, "custom_pages", @theme.custom_pages)
      append_hash_array_assignment(lines, "navigations", @theme.navigations)
      append_hash_array_assignment(lines, "resources", @theme.resources)
      append_array_assignment(lines, "embeds", @theme.embeds)

      if @theme.plugins.present?
        lines << "  theme.plugins = #{@theme.plugins.inspect}"
      end

      lines << "end"
      lines.join("\n") + "\n"
    end

    private

    def write_layout_file(output_path)
      filename = output_path.join("layout.rb")
      File.write(filename, render_layout_file)
    end

    def render_layout_file
      lines = []
      lines << "# frozen_string_literal: true"
      lines << ""
      lines << "LayoutParts.define do"

      @theme.layout_parts.each do |part_name|
        lines.concat(render_part_lines(part_name))
      end

      lines << "end"
      lines.join("\n") + "\n"
    end

    def write_template_file(output_path, view_template)
      filename = output_path.join("#{view_template[:name]}.rb")
      File.write(filename, render_template_file(view_template))
    end

    def render_template_file(view_template)
      lines = []
      lines << "# frozen_string_literal: true"
      lines << ""
      lines << "PageTemplate.define #{view_template[:name].inspect} do"

      append_metadata_line(lines, "title", view_template[:title], default: view_template[:name].to_s.humanize)
      append_metadata_line(lines, "description", view_template[:description])
      append_metadata_line(lines, "usage", view_template[:usage])
      append_metadata_line(lines, "exclude_from", view_template[:exclude_from])
      append_metadata_line(lines, "layout", view_template[:layout])

      lines << "" if lines.last != "PageTemplate.define #{view_template[:name].inspect} do"

      view_template[:parts].each do |part_name|
        lines.concat(render_part_lines(part_name))
      end

      lines << "end"
      lines.join("\n") + "\n"
    end

    def render_part_lines(part_name)
      definition = @parts_by_name.fetch(part_name.to_s)
      part_type = definition[:part_type]

      if part_type == "Spina::Parts::Repeater"
        render_repeater_lines(definition)
      else
        [render_part_line(definition)]
      end
    end

    def render_repeater_lines(definition)
      lines = []
      options = part_options(definition)
      line = "  repeater #{definition[:name].inspect}"
      line += ", #{format_options(options)}" if options.any?
      lines << "#{line} do"

      definition[:parts].each do |sub_part_name|
        sub_definition = @parts_by_name.fetch(sub_part_name.to_s)
        lines << "    #{render_part_call(sub_definition, indent: false)}"
      end

      lines << "  end"
      lines
    end

    def render_part_line(definition)
      "  #{render_part_call(definition)}"
    end

    def render_part_call(definition, indent: true)
      type = format_part_type(definition[:part_type])
      options = part_options(definition)
      call = "part #{definition[:name].inspect}, #{type}"
      call += ", #{format_options(options)}" if options.any?
      call
    end

    def format_part_type(part_type)
      symbol = PartType.symbol_for(part_type)
      symbol ? ":#{symbol}" : part_type.inspect
    end

    def part_options(definition)
      options = {}
      options[:title] = definition[:title] if definition[:title].present? && definition[:title] != definition[:name].to_s.humanize
      options[:hint] = definition[:hint] if definition[:hint].present?
      options[:item_name] = definition[:item_name] if definition[:item_name].present?
      options[:options] = definition[:options] if definition[:options].present?
      options
    end

    def format_options(options)
      options.map { |key, value| "#{key}: #{value.inspect}" }.join(", ")
    end

    def append_metadata_line(lines, method_name, value, default: nil)
      return if value.blank?
      return if default && value == default

      if method_name == "exclude_from"
        lines << "  exclude_from #{value.inspect}"
      else
        lines << "  #{method_name} #{value.inspect}"
      end
    end

    def append_array_assignment(lines, attribute, values)
      return if values.blank?

      lines << "  theme.#{attribute} = #{values.inspect}"
      lines << ""
    end

    def append_hash_array_assignment(lines, attribute, values)
      return if values.blank?

      lines << "  theme.#{attribute} = ["
      values.each do |value|
        lines << "    #{value.inspect},"
      end
      lines << "  ]"
      lines << ""
    end
  end
end
