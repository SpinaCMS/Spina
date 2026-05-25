module Spina
  class PageTemplate
    class << self
      def define(name, &block)
        raise ArgumentError, "No theme set for PageTemplate.define" unless current_theme_name

        definition = Definition.new(name.to_s, current_theme_name)
        definition.instance_eval(&block)
        register(definition)
        definition
      end

      def register(definition)
        registry[current_theme_name][definition.name] = definition
      end

      def for_theme(theme_name)
        registry[theme_name.to_s]&.values || []
      end

      def clear_for_theme(theme_name)
        registry.delete(theme_name.to_s)
      end

      def clear_all
        registry.clear
        @current_theme_name = nil
        LayoutParts.clear_all
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
        @registry ||= Hash.new { |hash, key| hash[key] = {} }
      end
    end

    class Definition
      include PartsDefinition

      attr_reader :name, :theme_name, :part_names, :title, :description, :usage, :exclude_from, :layout

      def initialize(name, theme_name)
        @name = name
        @theme_name = theme_name
        @part_names = []
        @part_definitions = {}
        @title = name.humanize
      end

      def title(value = nil)
        return @title if value.nil?

        @title = value
      end

      def description(value = nil)
        return @description if value.nil?

        @description = value
      end

      def usage(value = nil)
        return @usage if value.nil?

        @usage = value
      end

      def exclude_from(values = nil)
        return @exclude_from if values.nil?

        @exclude_from = values
      end

      def layout(value = nil)
        return @layout if value.nil?

        @layout = value
      end
    end
  end
end
