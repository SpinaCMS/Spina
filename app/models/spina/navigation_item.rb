module Spina
  class NavigationItem < ApplicationRecord
    extend Mobility
    belongs_to :navigation, touch: true, class_name: "Spina::Navigation"
    belongs_to :page, optional: true, class_name: "Spina::Page"
    
    # NavigationItems can be of two different kinds:
    # - A link to a page
    # - A link to a URL
    enum(:kind, {page: "page", url: "url"}, default: :page, suffix: true)

    has_ancestry

    scope :regular_pages, -> { joins(:page).where(spina_pages: {resource_id: nil}) }
    scope :sorted, -> { order("spina_navigation_items.position") }
    scope :live, -> { joins(:page).where(spina_pages: {draft: false, active: true}) }
    scope :in_menu, -> { joins(:page).where(spina_pages: {show_in_menu: true}) }
    scope :active, -> { joins(:page).where(spina_pages: {active: true}) }

    validates :page, uniqueness: {scope: :navigation}, presence: true, if: :page_kind?
    validates :url, presence: true, if: :url_kind?
    validates :url_title, presence: true, if: :url_kind?

    delegate :draft?, :homepage?, to: :page, allow_nil: true

    def menu_title
      return url_title if url_kind?
      page&.menu_title
    end
    
    def materialized_path
      return url if url_kind?
      page&.materialized_path
    end
  end
end
