module Spina
  class Plugin

    attr_reader :name, :namespace

    class << self

      @@plugins = []

      def all
        @@plugins
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
