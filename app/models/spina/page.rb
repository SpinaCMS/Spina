module Spina
  class Page < ApplicationRecord
    extend Mobility
    include Partable

    # Stores the old path when generating a new materialized_path
    attr_accessor :old_path

    # Page contains multiple parts called PageParts
    has_many :page_parts, dependent: :destroy, inverse_of: :page
    alias_attribute :parts, :page_parts
    accepts_nested_attributes_for :page_parts, allow_destroy: true

    # Orphaned pages are adopted by parent pages if available, otherwise become root
    has_ancestry orphan_strategy: :adopt

    # Pages can belong to navigations (optional)
    has_many :navigation_items, dependent: :destroy
    has_many :navigations, through: :navigation_items

    # Pages can belong to a resource
    belongs_to :resource, optional: true

    scope :regular_pages, ->  { where(resource: nil) }
    scope :resource_pages, -> { where.not(resource: nil) }
    scope :active, -> { where(active: true) }
    scope :sorted, -> { order(:position) }
    scope :live, -> { active.where(draft: false) }
    scope :in_menu, -> { where(show_in_menu: true) }

    # Save children to update all materialized_paths
    after_save :save_children
    after_save :touch_navigations
    after_save -> { page_parts.each(&:save) }

    # Create a 301 redirect if materialized_path changed
    after_save :rewrite_rule

    before_validation :set_materialized_path
    validates :title, presence: true

    translates :title, :description, :materialized_path
    translates :menu_title, :seo_title, default: -> { title }

    def to_s
      name
    end

    def page_id
      id
    end

    def url_title
      title.try(:parameterize)
    end

    def custom_page?
      !deletable
    end

    def save_children
      self.children.each(&:save)
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
      self.materialized_path += "-#{self.class.i18n.where(materialized_path: materialized_path).count}" if self.class.i18n.where(materialized_path: materialized_path).where.not(id: id).count > 0
      materialized_path
    end

    def cache_key
      super + "_" + Mobility.locale.to_s
    end

    def view_template_config(theme)
      view_template_name = view_template.presence || 'show'
      theme.view_templates.find { |template| template[:name] == view_template_name }
    end

    def view_template_page_parts(theme)
      theme.page_parts.select { |page_part| page_part[:name].in? view_template_config(theme)[:page_parts] }
    end

    private

      def touch_navigations
        navigations.update_all(updated_at: Time.zone.now)
      end

      def rewrite_rule
        RewriteRule.where(old_path: old_path).first_or_create.update_attributes(new_path: materialized_path) if old_path != materialized_path
      end

      def localized_materialized_path
        if I18n.locale == I18n.default_locale
          generate_materialized_path.prepend('/')
        else
          generate_materialized_path.prepend("/#{I18n.locale}/").gsub(/\/\z/, "")
        end
      end

      def generate_materialized_path
        if root?
          name == 'homepage' ? '' : "#{url_title}"
        else
          ancestors.collect(&:url_title).append(url_title).join('/')
        end
      end

  end
end
