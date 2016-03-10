module Spina
  class Plugin

    attr_reader :name, :title, :description, :spina_icon, :plugin_type, :namespace, :config

    @@plugins = []

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

    def to_s
      name
    end

    def url
      { controller: namespace }
    end

  end
end
