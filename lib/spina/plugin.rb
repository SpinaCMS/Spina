module Spina
  class Plugin

    attr_accessor :name, :namespace, :settings

    def create_setting_class!
      class_settings = data_mapped_settings_hash
      plugin_name = namespace

      klass = Class.new(::Spina::Setting) do
        jsonb_accessor :preferences, class_settings

        default_scope { where(plugin: "#{plugin_name}") }
      end
      "Spina::#{namespace_class}".constantize.const_set 'Setting', klass
    end

    private

    def map_data_type(type)
      case type
      when :wysiwyg then :text
      else type
      end
    end

    def namespace_class
      namespace.split('_').map{|part| part.camelize}.join
    end

    def data_mapped_settings_hash
      hash = Hash.new
      settings.each do |key, value|
        hash[key] = map_data_type(value)
      end
      hash
    end

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

        unless plugin.settings.nil?
          plugin.create_setting_class!
        end

        all << plugin
        plugin
      end

    end

  end
end
