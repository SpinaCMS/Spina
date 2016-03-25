module Spina
  class Page < ActiveRecord::Base
    include Spina::Partable

    translates :title, :menu_title, :seo_title, :description, :materialized_path

    attr_accessor :old_path

    has_ancestry orphan_strategy: :adopt # i.e. added to the parent of deleted node

    has_many :page_parts, dependent: :destroy

    before_validation :ensure_title
    before_validation :ancestry_is_nil
    before_validation :set_materialized_path
    after_save :save_children
    after_save :rewrite_rule

    accepts_nested_attributes_for :page_parts, allow_destroy: true
    validates_presence_of :title
    validates :materialized_path, uniqueness: true

    scope :sorted, -> { order('position') }
    scope :custom_pages, -> { where(deletable: false) }
    scope :live, -> { where(draft: false, active: true) }
    scope :in_menu, -> { where(show_in_menu: true) }
    scope :active, -> { where(active: true) }

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
      self.materialized_path = generate_materialized_path
      self.materialized_path += "-#{self.class.where(materialized_path: materialized_path).count}" if self.class.where(materialized_path: materialized_path).where.not(id: id).count > 0
      materialized_path
    end

    private

    def rewrite_rule
      RewriteRule.create(old_path: old_path, new_path: materialized_path) if old_path != materialized_path
    end

    def generate_materialized_path
      locale = I18n.locale
      if locale == I18n.default_locale
        if root?
          name == 'homepage' ? '/' : "/#{url_title}"
        else
          ancestors.collect(&:url_title).append(url_title).join('/').prepend('/')
        end
      else
        if root?
          name == 'homepage' ? "/#{locale}" : "/#{locale}/#{url_title}"
        else
          ancestors.collect(&:url_title).append(url_title).join('/').prepend("/#{locale}/")
        end
      end
    end

    def ancestry_is_nil
      self.ancestry = self.ancestry.presence
    end

    def ensure_title
      self.title = self.name.capitalize if self.title.blank? && self.name.present?
    end

  end
end
