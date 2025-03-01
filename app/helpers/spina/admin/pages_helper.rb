module Spina::Admin
  module PagesHelper
    def asset_available?(path)
      if defined?(Propshaft)
        check_propshaft_asset(path)
      elsif defined?(Sprockets)
        check_sprockets_asset(path)
      end
    end

    def build_parts(partable, parts)
      I18n.with_locale(@locale) do
        parts.map do |part|
          part_attributes = current_theme.parts.find { |p| p[:name].to_s == part.to_s }
          partable.part(part_attributes)
        end
      end
    end

    def parts_partial_namespace(part_type)
      part_type.tableize.sub(/\Aspina\/parts\//, "")
    end

    def option_label(part, value)
      t(["options", part.name, value].compact.join("."))
    end

    private

      def check_propshaft_asset(path)
        if Rails.configuration.assets.compile
          Rails.application.assets.load_path.find(path).present? rescue false
        else
          Rails.application.assets.asset_for(path).present? rescue false
        end
      end

      def check_sprockets_asset(path)
        if Rails.configuration.assets.compile
          Rails.application.precompiled_assets.include?(path)
        else
          Rails.application.assets_manifest.assets[path].present?
        end
      end

  end
end
