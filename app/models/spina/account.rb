module Spina
  class Account < ApplicationRecord
    include Partable

    serialize :preferences

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
        define_method method_name do
          self.preferences.try(:[], method_name.to_sym)
        end

        define_method "#{method_name}=" do |value|
          self.preferences ||= {}
          self.preferences[method_name.to_sym] = value
        end
      end
    end

    serialized_attr_accessor :google_analytics, :google_site_verification, :facebook, :twitter, :google_plus, :theme

    private

    def bootstrap_website
      theme_config = ::Spina::Theme.find_by_name(theme)
      if theme_config
        bootstrap_pages(theme_config)
        bootstrap_navigations(theme_config)
      end
    end

    def bootstrap_pages(theme)
      find_or_create_custom_pages(theme)
      deactivate_unused_view_templates(theme)
      activate_used_view_templates(theme)
    end

    def bootstrap_navigations(theme)
      theme.navigations.each_with_index do |navigation, index|
        Navigation.where(name: navigation[:name]).first_or_create.update_attributes(navigation.merge(position: index))
      end
    end

    def find_or_create_custom_pages(theme)
      theme.custom_pages.each do |page|
        Page.where(name: page[:name])
            .first_or_create(title: page[:title])
            .update_attributes(view_template: page[:view_template], deletable: page[:deletable])
      end
    end

    def deactivate_unused_view_templates(theme)
      Page.active.where.not(view_template: theme.view_templates.map{|h|h[:name]}).update_all(active: false)
    end

    def activate_used_view_templates(theme)
      Page.where(active: false, view_template: theme.view_templates.map{|h|h[:name]}).update_all(active: true)
    end

  end
end
