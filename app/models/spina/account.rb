module Spina
  class Account < ApplicationRecord
    include Partable
    include AttrJson::Record
    include AttrJson::NestedAttributes

    # Store each locale's content in [locale]_content as an array of parts
    Spina.config.locales.each do |locale|
      attr_json "#{locale}_content".to_sym, AttrJson::Type::SpinaPartsModel.new, array: true, default: -> { [] }
      attr_json_accepts_nested_attributes_for "#{locale}_content".to_sym
    end

    serialize :preferences

    after_save :bootstrap_website

    def find_part(name)
      send("#{I18n.locale}_content").find{|part| part.name.to_s == name.to_s}
    end

    def to_s
      name
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

    serialized_attr_accessor :google_analytics, :google_site_verification, :facebook, :twitter, :instagram, :youtube, :linkedin, :google_plus, :theme

    private

    def bootstrap_website
      theme_config = ::Spina::Theme.find_by_name(theme)
      if theme_config

        bootstrap_navigations(theme_config)
        bootstrap_pages(theme_config)
        bootstrap_resources(theme_config)
      end
    end

    def bootstrap_navigations(theme)
      theme.navigations.each_with_index do |navigation, index|
        Navigation.where(name: navigation[:name]).first_or_create.update(navigation.merge(position: index))
      end
    end

    def bootstrap_pages(theme)
      find_or_create_custom_pages(theme)
      deactivate_unused_view_templates(theme)
      activate_used_view_templates(theme)
    end

    def bootstrap_resources(theme)
      theme.resources.each do |resource|
        Resource.where(name: resource[:name]).first_or_create.update(resource)
      end
    end

    def find_or_create_custom_pages(theme)
      theme.custom_pages.each do |page|
        Page.where(name: page[:name])
            .first_or_create(title: page[:title])
            .update(view_template: page[:view_template], deletable: page[:deletable])
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
