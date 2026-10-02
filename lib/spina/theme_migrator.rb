module Spina
  class ThemeMigrator
    INITIALIZER_BACKUP_EXTENSION = ".rb.bak"
    MissingPartError = Class.new(ArgumentError)

    def self.initializer_backup_path(theme_name, root: nil)
      relative = "config/initializers/themes/#{theme_name}#{INITIALIZER_BACKUP_EXTENSION}"
      root ? root.join(relative) : relative
    end

    def initialize(theme)
      @theme = theme
      @parts_by_name = theme.parts.index_by { |part| part[:name].to_s }
    end

    def migrate_to(output_dir = nil)
      validate_part_references!

      output_path = Rails.root.join(output_dir || templates_path)
      FileUtils.mkdir_p(output_path)

      written_files = []
      begin
        if @theme.layout_parts.present?
          written_files << write_layout_file(output_path)
        end

        @theme.view_templates.each do |view_template|
          written_files << write_template_file(output_path, view_template)
        end
      rescue
        written_files.each { |path| FileUtils.rm_f(path) }
        raise
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

    def validate_part_references!
      missing = referenced_part_names.reject { |name| @parts_by_name.key?(name) }
      return if missing.empty?

      raise MissingPartError, <<~MESSAGE.squish
        Theme #{@theme.name.inspect} references undefined parts: #{missing.sort.map(&:inspect).join(", ")}.
        Add them to theme.parts before migrating.
      MESSAGE
    end

    def referenced_part_names
      names = []

      each_layout_part_name do |part_name|
        collect_part_names(part_name, names)
      end

      Array(@theme.view_templates).each do |view_template|
        Array(view_template[:parts]).each do |part_name|
          collect_part_names(part_name, names)
        end
      end

      names.uniq
    end

    def each_layout_part_name(&block)
      case @theme.layout_parts
      when Hash
        @theme.layout_parts.each_value do |part_names|
          Array(part_names).each(&block)
        end
      else
        Array(@theme.layout_parts).each(&block)
      end
    end

    def collect_part_names(part_name, names)
      name = part_name.to_s
      return if names.include?(name)

      names << name
      definition = @parts_by_name[name]
      return unless definition && definition[:parts]

      definition[:parts].each { |sub_part_name| collect_part_names(sub_part_name, names) }
    end

    def write_layout_file(output_path)
      filename = output_path.join("layout.rb")
      File.write(filename, render_layout_file)
      filename
    end

    def render_layout_file
      lines = []
      lines << "# frozen_string_literal: true"
      lines << ""
      lines << "Spina.define_layout_parts do"

      case @theme.layout_parts
      when Hash
        @theme.layout_parts.each do |section_name, part_names|
          lines << "  section #{section_name.to_sym.inspect} do"
          Array(part_names).each do |part_name|
            lines.concat(render_part_lines(part_name, indent: 2))
          end
          lines << "  end"
        end
      else
        @theme.layout_parts.each do |part_name|
          lines.concat(render_part_lines(part_name))
        end
      end

      lines << "end"
      lines.join("\n") + "\n"
    end

    def write_template_file(output_path, view_template)
      filename = output_path.join("#{view_template[:name]}.rb")
      File.write(filename, render_template_file(view_template))
      filename
    end

    def render_template_file(view_template)
      lines = []
      lines << "# frozen_string_literal: true"
      lines << ""
      lines << "Spina.define_template #{view_template[:name].inspect} do"

      append_metadata_line(lines, "title", view_template[:title], default: view_template[:name].to_s.humanize)
      append_metadata_line(lines, "description", view_template[:description])
      append_metadata_line(lines, "usage", view_template[:usage])
      append_metadata_line(lines, "exclude_from", view_template[:exclude_from])
      append_metadata_line(lines, "layout", view_template[:layout])

      lines << "" if lines.last != "Spina.define_template #{view_template[:name].inspect} do"

      view_template[:parts].each do |part_name|
        lines.concat(render_part_lines(part_name))
      end

      lines << "end"
      lines.join("\n") + "\n"
    end

    def render_part_lines(part_name, indent: 1)
      definition = @parts_by_name.fetch(part_name.to_s)

      if definition[:part_type] == "Spina::Parts::Repeater"
        render_repeater_lines(definition, indent: indent)
      else
        [render_part_line(definition, indent: indent)]
      end
    end

    def render_repeater_lines(definition, indent: 1)
      prefix = "  " * indent
      lines = []
      options = part_options(definition)
      line = "#{prefix}repeater #{definition[:name].inspect}"
      line += ", #{format_options(options)}" if options.any?
      lines << "#{line} do"

      definition[:parts].each do |sub_part_name|
        lines.concat(render_part_lines(sub_part_name, indent: indent + 1))
      end

      lines << "#{prefix}end"
      lines
    end

    def render_part_line(definition, indent: 1)
      "#{"  " * indent}#{render_part_call(definition)}"
    end

    def render_part_call(definition)
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

      lines << "  #{method_name} #{value.inspect}"
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
