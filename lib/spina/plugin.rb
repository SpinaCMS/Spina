module Spina
  class Plugin

    attr_accessor :name, :namespace

    class << self

      def all
        ::Spina::PLUGINS
      end

      def find_by_name(name)
        all.find { |plugin| plugin.name == name }
      end

      def register
        plugin = new
        yield plugin
        raise 'Missing plugin name' if plugin.name.nil?
        raise 'Missing plugin namespace' if plugin.namespace.nil?
        all << plugin
        plugin
      end

    end

  end
end
