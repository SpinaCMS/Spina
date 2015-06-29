module Spina
  class Account < ActiveRecord::Base
    serialize :preferences
    include Spina::Partable

    mount_uploader :logo, LogoUploader

    has_many :layout_parts, dependent: :destroy
    accepts_nested_attributes_for :layout_parts, allow_destroy: true

    alias_method :layout_part, :part
    alias_method :parts, :layout_parts

    after_save :bootstrap_website

    def to_s
      name
    end

    # def layout_part(layout_part)
    #   part(layout_part)
    # end

    def content(layout_part)
      layout_part = layout_parts.where(name: layout_part).first
      layout_part.try(:content)
    end

    private

    def bootstrap_website
      theme = ::Spina.theme(self.theme)
      bootstrap_pages(theme) if theme
    end

    def bootstrap_pages(theme)
      find_or_create_custom_pages(theme)
      deactivate_unused_view_templates(theme)
      activate_used_view_templates(theme)
    end

    def find_or_create_custom_pages(theme)
      theme.config.custom_pages.each do |page| 
        Page.where(name: page[:name], deletable: false).first_or_create(title: page[:title], view_template: page[:view_template]).activate!
      end
    end

    def deactivate_unused_view_templates(theme)
      Page.where.not(view_template: theme.config.view_templates.map{|t|t[0]}).each &:deactivate!
    end

    def activate_used_view_templates(theme)
      Page.where(view_template: theme.config.view_templates.map{|t|t[0]}).each &:activate!
    end

    def self.serialized_attr_accessor(*args)
      args.each do |method_name|
        eval "
          def #{method_name}
            (self.preferences || {})[:#{method_name}]
          end

          def #{method_name}=(value)
            self.preferences ||= {}
            self.preferences[:#{method_name}] = value
          end
        "
      end
    end

    serialized_attr_accessor :google_analytics, :google_site_verification, :facebook, :twitter, :google_plus, :theme, :aviary_api_key, :aviary_language, :ngrok_address

  end
end
