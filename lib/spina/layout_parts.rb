module Spina
  class LayoutParts
    class << self
      def define(&block)
        raise ArgumentError, "No theme set for LayoutParts.define" unless current_theme_name

        definition = Definition.new(current_theme_name)
        definition.instance_eval(&block)
        register(definition)
        definition
      end

      def register(definition)
        synchronize { registry[current_theme_name] = definition }
      end

      def for_theme(theme_name)
        synchronize { registry[theme_name.to_s] }
      end

      def clear_for_theme(theme_name)
        synchronize { registry.delete(theme_name.to_s) }
      end

      def clear_all
        synchronize do
          registry.clear
          self.current_theme_name = nil
        end
      end

      def with_theme(theme_name)
        previous = current_theme_name
        self.current_theme_name = theme_name.to_s
        yield
      ensure
        self.current_theme_name = previous
      end

      def current_theme_name
        ActiveSupport::IsolatedExecutionState[:spina_layout_parts_theme]
      end

      def current_theme_name=(name)
        if name.nil?
          ActiveSupport::IsolatedExecutionState.delete(:spina_layout_parts_theme)
        else
          ActiveSupport::IsolatedExecutionState[:spina_layout_parts_theme] = name.to_s
        end
      end

      private

      def synchronize(&block)
        mutex.synchronize(&block)
      end

      def mutex
        @mutex
      end

      def registry
        @registry
      end
    end

    @mutex = Mutex.new
    @registry = {}

    class Definition
      include PartsDefinition

      attr_reader :theme_name, :part_names, :sections

      def initialize(theme_name)
        @theme_name = theme_name
        @part_names = []
        @part_definitions = {}
        @sections = nil
        @current_section = nil
      end

      def section(name, &block)
        raise ArgumentError, "Section #{name} requires a block" unless block
        raise ArgumentError, "Cannot nest layout part sections" if @current_section
        raise ArgumentError, "Cannot mix unsectioned layout parts with sections" if @sections.nil? && @part_names.any?

        @sections ||= {}
        section_name = name.to_sym
        @sections[section_name] ||= []
        @current_section = section_name
        instance_eval(&block)
      ensure
        @current_section = nil
      end

      def part(name, type, **options)
        super
        track_section_part!(name)
      end

      def repeater(name, **options, &block)
        super
        track_section_part!(name)
      end

      def layout_part_names
        @sections.presence || @part_names
      end

      private

      def track_section_part!(name)
        return unless @current_section

        @sections[@current_section] << name.to_s
      end
    end
  end
end
