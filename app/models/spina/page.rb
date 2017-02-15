module Spina
  class Page < ApplicationRecord
    include Spina::Partable

    translates :title, :menu_title, :seo_title, :description, :materialized_path

    attr_accessor :old_path

    has_ancestry orphan_strategy: :adopt # i.e. added to the parent of deleted node

    has_many :page_parts, dependent: :destroy, inverse_of: :page
    has_many :navigation_items, dependent: :destroy
    has_many :navigations, through: :navigation_items

    before_validation :ensure_title
    before_validation :ancestry_is_nil
    before_validation :set_materialized_path
    after_save :save_children
    after_save :rewrite_rule
    after_create :add_to_navigation

    accepts_nested_attributes_for :page_parts, allow_destroy: true
    validates_presence_of :title
    validates :materialized_path, uniqueness: true

    scope :sorted, -> { order('position') }
    scope :custom_pages, -> { where(deletable: false) }
    scope :live, -> { where(draft: false, active: true) }
    scope :in_menu, -> { where(show_in_menu: true) }
    scope :active, -> { where(active: true) }
    scope :not_active, -> { where(active: false) }
    scope :by_name, ->(name) { where(name: name) }
    scope :not_by_config_theme, ->(theme) { where.not(view_template: theme.view_templates.map { |h| h[:name] }) }
    scope :by_config_theme, ->(theme) { where(view_template: theme.view_templates.map { |h| h[:name] }) }

    alias_attribute :page_part, :part
    alias_attribute :parts, :page_parts

    def to_s
      name
    end

    def url_title
      title.try(:parameterize)
    end

    def custom_page?
      !deletable
    end

    def save_children
      self.children.each { |child| child.save }
    end

    def menu_title
      read_attribute(:menu_title).blank? ? title : read_attribute(:menu_title)
    end

    def seo_title
      read_attribute(:seo_title).blank? ? title : read_attribute(:seo_title)
    end

    def has_content?(page_part)
      content(page_part).present?
    end

    def content(page_part)
      page_part = page_parts.where(name: page_part).first
      page_part.try(:content)
    end

    def live?
      !draft? && active?
    end

    def previous_sibling
      self.siblings.where('position < ?', self.position).sorted.last
    end

    def next_sibling
      self.siblings.where('position > ?', self.position).sorted.first
    end

    def set_materialized_path
      self.old_path = materialized_path
      self.materialized_path = localized_materialized_path
      self.materialized_path += "-#{self.class.where(materialized_path: materialized_path).count}" if self.class.where(materialized_path: materialized_path).where.not(id: id).count > 0
      materialized_path
    end

    def cache_key
      super + "_" + Globalize.locale.to_s
    end

    def view_template_config(theme)
      view_template_name = view_template.presence || 'show'
      theme.view_templates.find { |template| template[:name] == view_template_name }
    end

    def view_template_page_parts(theme)
      theme.page_parts.select { |page_part| page_part[:name].in? view_template_config(theme)[:page_parts] }
    end

    def full_materialized_path
      File.join(Spina::Engine.routes.url_helpers.root_path, materialized_path)
    end

    private

    def rewrite_rule
      RewriteRule.create(old_path: old_path, new_path: materialized_path) if old_path != materialized_path
    end

    def localized_materialized_path
      if I18n.locale == I18n.default_locale
        generate_materialized_path.prepend('/')
      else
        generate_materialized_path.prepend("/#{I18n.locale}/")
      end
    end

    def generate_materialized_path
      if root?
        name == 'homepage' ? '' : "#{url_title}"
      else
        ancestors.collect(&:url_title).append(url_title).join('/')
      end
    end

    def ancestry_is_nil
      self.ancestry = self.ancestry.presence
    end

    def ensure_title
      self.title = self.name.capitalize if self.title.blank? && self.name.present?
    end

    def add_to_navigation
      navigations << Spina::Navigation.where(auto_add_pages: true)
    end

  end
end
