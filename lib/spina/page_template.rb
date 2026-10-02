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
        synchronize do
          (registry[current_theme_name] ||= {})[definition.name] = definition
        end
      end

      def for_theme(theme_name)
        synchronize do
          registry[theme_name.to_s]&.values&.dup || []
        end
      end

      def clear_for_theme(theme_name)
        synchronize { registry.delete(theme_name.to_s) }
      end

      def clear_all
        synchronize do
          registry.clear
          self.current_theme_name = nil
        end
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
        ActiveSupport::IsolatedExecutionState[:spina_page_template_theme]
      end

      def current_theme_name=(name)
        if name.nil?
          ActiveSupport::IsolatedExecutionState.delete(:spina_page_template_theme)
        else
          ActiveSupport::IsolatedExecutionState[:spina_page_template_theme] = name.to_s
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

      attr_reader :name, :theme_name, :part_names

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
