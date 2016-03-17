module Spina
  class Plugin

    @@plugins = []

    attr_reader :name, :title, :description, :spina_icon, :plugin_type, :namespace, :config

    class << self

      def all
        @@plugins
      end

      def find_all_by_type(type)
        @@plugins.find_all { |plugin| plugin.plugin_type == type }
      end

      def find_by_name(name)
        @@plugins.find { |plugin| plugin.name == name }
      end

      def register(plugin)
        @@plugins << plugin
      end

    end

    def initialize(args)
      args.each { |k,v| instance_variable_set("@#{k}", v) }
    end

  end
end
