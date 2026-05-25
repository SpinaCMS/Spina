module Spina
  module PartsDefinition
    def part(name, type, **options)
      definition = build_part_definition(name, type, **options)
      register_part_definition(definition)
      part_names << definition[:name]
    end

    def repeater(name, **options, &block)
      raise ArgumentError, "Repeater #{name} requires a block" unless block

      builder = RepeaterBuilder.new
      builder.instance_eval(&block)

      builder.part_definitions.each do |definition|
        register_part_definition(definition)
      end

      repeater_definition = {
        name: name.to_s,
        title: options[:title] || default_title(name),
        part_type: PartType.resolve(:repeater),
        parts: builder.part_names
      }
      repeater_definition[:item_name] = options[:item_name] if options[:item_name]
      repeater_definition[:hint] = options[:hint] if options[:hint]

      register_part_definition(repeater_definition)
      part_names << repeater_definition[:name]
    end

    def part_definitions
      @part_definitions.values
    end

    private

    def build_part_definition(name, type, **options)
      {
        name: name.to_s,
        title: options[:title] || default_title(name),
        part_type: PartType.resolve(type)
      }.tap do |definition|
        definition[:hint] = options[:hint] if options[:hint]
        definition[:item_name] = options[:item_name] if options[:item_name]
        definition[:options] = options[:options] if options[:options]
        definition[:parts] = options[:parts] if options[:parts]
      end
    end

    def register_part_definition(definition)
      existing = @part_definitions[definition[:name]]
      if existing && !definitions_compatible?(existing, definition)
        raise ArgumentError, "Part #{definition[:name].inspect} is defined differently in multiple places"
      end

      @part_definitions[definition[:name]] = existing ? merge_metadata(existing, definition) : definition
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

    def default_title(name)
      name.to_s.humanize
    end

    class RepeaterBuilder
      attr_reader :part_definitions, :part_names

      def initialize
        @part_definitions = []
        @part_names = []
      end

      def part(name, type, **options)
        definition = {
          name: name.to_s,
          title: options[:title] || name.to_s.humanize,
          part_type: PartType.resolve(type)
        }
        definition[:hint] = options[:hint] if options[:hint]
        definition[:options] = options[:options] if options[:options]

        @part_definitions << definition
        @part_names << definition[:name]
      end
    end
  end
end
