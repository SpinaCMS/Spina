module Spina
  class NavigationItem < ApplicationRecord
    belongs_to :navigation
    belongs_to :page

    has_ancestry orphan_strategy: :adopt

    scope :sorted, -> { order('spina_navigation_items.position') }
    scope :live, -> { joins(:page).where(spina_pages: {draft: false, active: true}) }
    scope :in_menu, -> { joins(:page).where(spina_pages: {show_in_menu: true}) }
    scope :active, -> { joins(:page).where(spina_pages: {active: true}) }

    validates :page, uniqueness: {scope: :navigation}

    delegate :menu_title, :materialized_path, to: :page
  end
end