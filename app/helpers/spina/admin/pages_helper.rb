module Spina::Admin
  module PagesHelper
    def asset_available?(path)
      if defined?(Propshaft)
        check_propshaft_asset(path)
      elsif defined?(Sprockets)
        check_sprockets_asset(path)
      end
    end

    def build_parts(partable, parts, context: parts_context_for(partable))
      I18n.with_locale(@locale) do
        parts.map do |part|
          part_attributes = find_part_definition(part, context: context, view_template: current_view_template)
          partable.part(part_attributes)
        end
      end
    end

    def find_part_definition(name, context: parts_context, view_template: current_view_template)
      Spina::Current.theme.part_definitions_for(context, view_template: view_template).find do |part|
        part[:name].to_s == name.to_s
      end
    end

    def current_view_template
      @page&.view_template
    end

    def parts_context
      @parts_context ||= :page
    end

    def parts_partial_namespace(part_type)
      part_type.tableize.sub(/\Aspina\/parts\//, "")
    end

    def option_label(part, value)
      t(["options", part.name, value].compact.join("."))
    end

    private

    def parts_context_for(partable)
      partable.is_a?(Spina::Account) ? :layout : parts_context
    end

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
