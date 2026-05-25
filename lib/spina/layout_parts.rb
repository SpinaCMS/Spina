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
        registry[current_theme_name] = definition
      end

      def for_theme(theme_name)
        registry[theme_name.to_s]
      end

      def clear_for_theme(theme_name)
        registry.delete(theme_name.to_s)
      end

      def clear_all
        registry.clear
        @current_theme_name = nil
      end

      def with_theme(theme_name)
        previous = current_theme_name
        self.current_theme_name = theme_name.to_s
        yield
      ensure
        self.current_theme_name = previous
      end

      def current_theme_name
        @current_theme_name
      end

      def current_theme_name=(name)
        @current_theme_name = name&.to_s
      end

      def registry
        @registry ||= {}
      end
    end

    class Definition
      include PartsDefinition

      attr_reader :theme_name, :part_names

      def initialize(theme_name)
        @theme_name = theme_name
        @part_names = []
        @part_definitions = {}
      end
    end
  end
end
