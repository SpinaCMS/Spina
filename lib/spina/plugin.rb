module Spina
  class Plugin

    attr_accessor :name, :namespace

    class << self

      @@plugins = []

      def all
        @@plugins
      end

      def find_by_name(name)
        @@plugins.find { |plugin| plugin.name == name }
      end

      def register
        plugin = new
        yield plugin
        raise 'Missing plugin name' if plugin.name.nil?
        raise 'Missing plugin namespace' if plugin.namespace.nil?
        @@plugins << plugin
        plugin
      end

    end

  end
end
