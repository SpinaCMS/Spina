module Spina
  class PageTemplatesCompiler
    attr_reader :layout_part_definitions, :view_templates, :layout_part_names

    def initialize(page_templates, layout_parts: nil)
      @page_templates = page_templates
      @layout_parts = layout_parts
      compile!
    end

    private

    def compile!
      @layout_part_definitions = compile_part_definitions(@layout_parts&.part_definitions || [])
      @layout_part_names = @layout_parts&.part_names || []
      @view_templates = @page_templates.map { |template| build_view_template(template) }
    end

    def compile_part_definitions(definitions)
      parts_by_name = {}

      definitions.each do |definition|
        merge_part_definition!(parts_by_name, definition)
      end

      parts_by_name.values
    end

    def merge_part_definition!(parts_by_name, definition)
      name = definition[:name]
      existing = parts_by_name[name]

      if existing && !definitions_compatible?(existing, definition)
        raise ArgumentError, "Part #{name.inspect} has conflicting definitions"
      end

      parts_by_name[name] = existing ? merge_metadata(existing, definition) : definition.dup
    end

    def definitions_compatible?(left, right)
      left.slice(:part_type, :options, :item_name, :parts) == right.slice(:part_type, :options, :item_name, :parts)
    end

    def merge_metadata(existing, incoming)
      existing.dup.tap do |merged|
        merged[:title] ||= incoming[:title]
        merged[:hint] ||= incoming[:hint]
      end
    end

    def build_view_template(template)
      {
        name: template.name,
        title: template.title,
        parts: template.part_names
      }.tap do |view_template|
        view_template[:description] = template.description if template.description
        view_template[:usage] = template.usage if template.usage
        view_template[:exclude_from] = template.exclude_from if template.exclude_from
        view_template[:layout] = template.layout if template.layout
      end
    end
  end
end
