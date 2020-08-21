module Spina
  class Page < ApplicationRecord
    extend Mobility
    include AttrJson::Record
    include AttrJson::NestedAttributes
    include Partable
    include TranslatedContent

    # Stores the old path when generating a new materialized_path
    attr_accessor :old_path

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

    # Copy resource from parent
    before_save :set_resource_from_parent, if: -> { parent.present? }

    # Save children to update all materialized_paths
    after_save :save_children
    after_save :touch_navigations

    # Create a 301 redirect if materialized_path changed
    after_save :rewrite_rule

    before_validation :set_materialized_path
    validates :title, presence: true

    translates :title, fallbacks: true
    translates :description, :materialized_path
    translates :menu_title, :seo_title, :url_title, default: -> { title }

    def to_s
      name
    end

    def page_id
      id
    end

    def slug
      url_title&.parameterize
    end

    def custom_page?
      !deletable
    end

    def save_children
      children.each(&:save)
    end

    def live?
      !draft? && active?
    end

    def previous_sibling
      siblings.where('position < ?', position).sorted.last
    end

    def next_sibling
      siblings.where('position > ?', position).sorted.first
    end

    def set_materialized_path
      self.old_path = materialized_path
      self.materialized_path = localized_materialized_path
      self.materialized_path = localized_materialized_path + "-#{Page.i18n.where(materialized_path: materialized_path).count}" if Page.i18n.where(materialized_path: materialized_path).where.not(id: id).count > 0
      materialized_path
    end

    def cache_key
      super + "_" + Mobility.locale.to_s
    end

    def view_template_config(theme)
      view_template_name = view_template.presence || 'show'
      theme.view_templates.find { |template| template[:name] == view_template_name }
    end

    private

      def set_resource_from_parent
        self.resource_id = parent.resource_id 
      end

      def touch_navigations
        navigations.update_all(updated_at: Time.zone.now)
      end

      def rewrite_rule
        RewriteRule.where(old_path: old_path).first_or_create.update(new_path: materialized_path) if old_path != materialized_path
      end

      def localized_materialized_path
        if Mobility.locale == I18n.default_locale
          generate_materialized_path.prepend('/')
        else
          generate_materialized_path.prepend("/#{Mobility.locale}/").gsub(/\/\z/, "")
        end
      end

      def generate_materialized_path
        path_fragments = [resource&.slug]
        path_fragments.append *ancestors.collect(&:slug)
        path_fragments.append(slug) unless name == 'homepage'
        path_fragments.compact.map(&:parameterize).join('/')
      end

  end
end
