module Spina
  class NavigationItem < ApplicationRecord
    extend Mobility
    belongs_to :navigation, touch: true
    belongs_to :page, optional: true

    has_ancestry

    scope :regular_pages, -> { joins(:page).where(spina_pages: {resource_id: nil}) }
    scope :sorted, -> { order("spina_navigation_items.position") }
    scope :live, -> { joins(:page).where(spina_pages: {draft: false, active: true}) }
    scope :in_menu, -> { joins(:page).where(spina_pages: {show_in_menu: true}) }
    scope :active, -> { joins(:page).where(spina_pages: {active: true}) }

    validates :page, uniqueness: {scope: :navigation, allow_nil: true}

    with_options if: ->(item) {item.page.blank?} do
      validates :url, presence: true
      validates :url_title, presence: true
    end

    translates :url_title

    delegate :draft?, :homepage?, to: :page, allow_nil: true

    def menu_title
      page&.menu_title || url_title
    end
    
    def materialized_path
      page&.materialized_path || url
    end
  end
end
