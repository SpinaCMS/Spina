module Spina
  class Account < ActiveRecord::Base
    serialize :preferences
    include Spina::Partable

    mount_uploader :logo, LogoUploader

    has_many :layout_parts, dependent: :destroy
    accepts_nested_attributes_for :layout_parts, allow_destroy: true

    alias_attribute :layout_part, :part
    alias_attribute :parts, :layout_parts

    after_save :bootstrap_website

    def to_s
      name
    end

    def content(layout_part)
      layout_parts.find_by(name: layout_part).try(:content)
    end

    def self.serialized_attr_accessor(*args)
      args.each do |method_name|
        eval "
          def #{method_name}
            self.preferences.try(:[], :#{method_name})
          end

          def #{method_name}=(value)
            self.preferences ||= {}
            self.preferences[:#{method_name}] = value
          end
        "
      end
    end

    serialized_attr_accessor :google_analytics, :google_site_verification, :facebook, :twitter, :google_plus, :theme

    private

    def bootstrap_website
      theme_config = ::Spina::Theme.find_by_name(theme)
      bootstrap_pages(theme_config) if theme_config
    end

    def bootstrap_pages(theme)
      find_or_create_custom_pages(theme)
      deactivate_unused_view_templates(theme)
      activate_used_view_templates(theme)
    end

    def find_or_create_custom_pages(theme)
      theme.custom_pages.each do |page|
        Page.by_name(page[:name])
            .first_or_create(title: page[:title])
            .update_columns(view_template: page[:view_template], deletable: page[:deletable])
      end
    end

    def deactivate_unused_view_templates(theme)
      Page.active.not_by_config_theme(theme).update_all(active: false)
    end

    def activate_used_view_templates(theme)
      Page.not_active.by_config_theme(theme).update_all(active: true)
    end

  end
end
