module Spina
  class Page < ApplicationRecord
    extend Mobility
    include AttrJson::Record
    include AttrJson::NestedAttributes
    include Partable
    include TranslatedContent

    # Stores the old path when generating a new materialized_path
    attr_accessor :old_path

    # ADDITION
    # make json_attributes more accessible for getting/setting
    attr_json :themes, :string, array: true
    attr_json :homepage_for_themes, :string, array: true

    # Orphaned pages are adopted by parent pages if available, otherwise become root
    has_ancestry orphan_strategy: :adopt

    # Pages can belong to navigations (optional)
    has_many :navigation_items, dependent: :destroy
    has_many :navigations, through: :navigation_items

    # Pages can belong to a resource
    belongs_to :resource, optional: true, touch: true

    scope :main, -> { where(resource_id: nil) }
    scope :regular_pages, ->  { main }
    scope :resource_pages, -> { where.not(resource: nil) }
    scope :active, -> { where(active: true) }
    scope :sorted, -> { order(:position) }
    scope :live, -> { active.where(draft: false) }
    scope :in_menu, -> { where(show_in_menu: true) }

    # ADDITION
    # returns records where json_attributes['themes'] has a matching value
    scope :for_theme, ->(theme_name) { where("json_attributes -> 'themes' ? :theme_name", theme_name:) }

    before_create :set_default_position

    # Copy resource from parent
    before_save :set_resource_from_parent, if: -> { parent.present? }

    # ADDITION
    # ensure page has a theme stored
    before_save :set_theme

    # Save children to update all materialized_paths
    after_save :save_children
    after_save :touch_navigations

    # ADDITION:
    # Only one page in a theme can be marked as the homepage
    after_save :unset_homepage_on_theme_siblings, if: -> { is_homepage }

    # Create a 301 redirect if materialized_path changed
    after_update :rewrite_rule

    before_validation :set_materialized_path
    before_validation :themes_cant_be_blank, if: -> { themes.nil? || themes.empty? }
    validates :title, presence: true

    translates :title, fallbacks: true
    translates :description, :materialized_path
    translates :menu_title, :seo_title, :url_title, default: -> { title }

    # ADDITION
    # for Spina::Frontend#page
    def self.find_by_path_locale_and_theme(locale: I18n.default_locale, theme_name: 'default', path: '/')
      I18n.with_locale(locale) do
        theme_pages = Page.i18n.for_theme(theme_name)
        return Page.none unless theme_pages.any?

        # return nil if all else fails
        page = nil

        # try to find homepage if path is root
        page = theme_pages.where(is_homepage: true).first.presence if path == ('/' || "/#{locale}")
        # try to find page with matching path
        page ||= theme_pages.where(materialized_path: path).first.presence

        page
      end
    end

    # ADDITION
    # used by 'actions_components.html'
    def homepage_for_theme?(theme_name)
      return false unless is_homepage?

      homepage_for_themes.include? theme_name
    end

    def to_s
      title
    end

    def page_id
      id
    end

    def slug
      url_title.to_s.to_slug.transliterate(*Spina.config.transliterations).normalize.to_s
    end

    # DEPRECIATE!
    # Setting homepage is now a boolean attr
    # def homepage?
    #   name == 'homepage'
    # end

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

    def view_template_config(theme)
      view_template_name = view_template.presence || 'show'
      theme.view_templates.find { |template| template[:name] == view_template_name }
    end

    # ADDITION
    # make #is_homepage assignable if included in hash
    # make #deleteable assignment less brittle
    # @See Spina::Account#find_or_create_custom_pages
    def assign_attributes_from_theme_custom_page(page_hsh: {})
      self.title = page_hsh[:title] || 'No Title Provided'
      self.view_template = page_hsh[:view_template]
      self.is_homepage |= page_hsh[:homepage]

      return unless page_hsh[:deletable].present?

      self.deletable = page_hsh[:deletable]
    end

    # ADDITION
    # Associate the page with the theme
    #   using Page#json_attributes['theme']
    # mark the page as the theme's homepage
    #   if page_hsh[:homepage] is true
    #   using Page#json_attributes['homepage_for_themes']
    # @See Spina::Account#find_or_create_custom_pages
    def assign_json_attributes_from_theme_custom_page(theme: 'default', page_hsh: {})
      self.themes ||= []
      self.themes |= [theme.name]

      return unless page_hsh[:homepage].present?

      self.homepage_for_themes ||= []
      self.homepage_for_themes |= [theme.name]
    end

    private

      def set_default_position
        self.position ||= self.class.maximum(:position).to_i.next
      end

      def set_resource_from_parent
        self.resource_id = parent.resource_id
      end

      # ADDITION
      # page keeps track of the selected theme when the page was created
      def set_theme
        self.themes ||= []
        self.themes |= [theme]

        self.homepage_for_themes ||= []
        self.homepage_for_themes |= [theme] if is_homepage?
      end

      def touch_navigations
        navigations.update_all(updated_at: Time.zone.now)
      end

      def rewrite_rule
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
        path_fragments.append *ancestors.collect(&:slug)
        # ADDITION
        # use new is_homepage? bool
        path_fragments.append(slug) unless is_homepage?
        path_fragments.compact.map(&:parameterize).join('/')
      end

      def duplicate_materialized_path?
        self.class.where.not(id: id).i18n.where(materialized_path: materialized_path).exists?
      end

      # ADDITION
      # when saving a record, ensure only one page
      # is set as the homepage, scoped to a theme
      def unset_homepage_on_theme_siblings
        # debugger

        theme_siblings = Spina::Page.for_theme(theme).excluding(self)

        return if theme_siblings.none?

        theme_siblings.each do |sib|
          sib.is_homepage = false
          sib.homepage_for_themes ||= []
          sib.homepage_for_themes -= [theme]

          sib.save!
        end
      end

      # ADDITION
      # used by #unset_homepage_on_theme_siblings
      # used by #set_theme
      # used by #unset_homepage_on_theme_siblings
      def theme
        Spina::Current.account&.theme || Spina::Account.first&.theme || 'default'
      end

      # ADDITION
      # Pages could be turned into ghosts if they are not associated with any theme
      def themes_cant_be_blank
        errors.add(:themes, I18n.t('activerecord.errors.models.spina/page.attributes.themes.required'))
      end
  end
end
