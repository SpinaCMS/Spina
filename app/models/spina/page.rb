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
    has_ancestry orphan_strategy: :adopt,
                 counter_cache: :ancestry_children_count,
                 cache_depth: true

    # Pages can belong to navigations (optional)
    has_many :navigation_items, dependent: :destroy
    has_many :navigations, through: :navigation_items

    # Pages can belong to a resource
    belongs_to :resource, optional: true, touch: true

    scope :main, -> { where(resource_id: nil) }
    scope :regular_pages, -> { main }
    scope :resource_pages, -> { where.not(resource: nil) }
    scope :active, -> { where(active: true) }
    scope :sorted, -> { order(:position) }
    scope :live, -> { active.where(draft: false) }
    scope :in_menu, -> { where(show_in_menu: true) }

    before_create :set_default_position

    # Copy resource from parent
    before_save :set_resource_from_parent, if: -> { parent.present? }

    # Save children to update all materialized_paths
    after_save :save_children
    after_save :touch_navigations

    # Create a 301 redirect if materialized_path changed
    after_update :rewrite_rule

    before_validation :set_materialized_path
    validates :title, presence: true

    translates :title, fallbacks: true
    translates :description, :materialized_path
    translates :menu_title, :seo_title, :url_title, default: -> { title }

    def to_s
      title
    end

    def page_id
      id
    end

    def slug
      url_title.to_s.to_slug.transliterate(*Spina.config.transliterations).normalize.to_s
    end

    def homepage?
      name == "homepage"
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
      siblings.where("position < ?", position).sorted.last
    end

    def next_sibling
      siblings.where("position > ?", position).sorted.first
    end

    def set_materialized_path
      self.old_path = materialized_path
      self.materialized_path = localized_materialized_path

      # Append counter to duplicate materialized_path
      i = 0
      while duplicate_materialized_path?
        i += 1
        self.materialized_path = localized_materialized_path.concat("-#{i}")
      end
    end

    def cache_key
      super + "_" + Mobility.locale.to_s
    end

    private

    def set_default_position
      self.position ||= self.class.maximum(:position).to_i.next
    end

    def set_resource_from_parent
      self.resource_id = parent.resource_id
    end

    def touch_navigations
      navigations.update_all(updated_at: Time.zone.now)
    end

    def rewrite_rule
      RewriteRule.where(new_path: old_path, old_path: materialized_path).delete_all
      RewriteRule.where(new_path: old_path).update(new_path: materialized_path)
      RewriteRule.where(old_path: old_path).first_or_create.update(new_path: materialized_path) if old_path != materialized_path
    end

    def localized_materialized_path
      segments = if Mobility.locale == I18n.default_locale
        [Spina.mounted_at, generate_materialized_path]
      else
        [Spina.mounted_at, Mobility.locale, generate_materialized_path]
      end
      File.join(*segments.map(&:to_s).compact)
    end

    def generate_materialized_path
      path_fragments = [resource&.slug]
      path_fragments.append(*ancestors.collect(&:slug))
      path_fragments.append(slug) unless homepage?
      path_fragments.compact.map(&:parameterize).join("/")
    end

    def duplicate_materialized_path?
      self.class.where.not(id: id).i18n.where(materialized_path: materialized_path).exists?
    end
  end
end
