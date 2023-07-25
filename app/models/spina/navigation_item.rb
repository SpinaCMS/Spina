module Spina
  class NavigationItem < ApplicationRecord
    belongs_to :navigation, touch: true
    belongs_to :page, optional: true

    has_ancestry

    scope :regular_pages, -> { joins(:page).where(spina_pages: {resource_id: nil}) }
    scope :sorted, -> { order("spina_navigation_items.position") }
    scope :live, -> { joins(:page).where(spina_pages: {draft: false, active: true}) }
    scope :in_menu, -> { joins(:page).where(spina_pages: {show_in_menu: true}) }
    scope :active, -> { joins(:page).where(spina_pages: {active: true}) }

    validates :page, uniqueness: {scope: :navigation, allow_nil: true}
    validate :url_and_url_label_presence
    validate :url_or_page_presence

    delegate :draft?, :homepage?, to: :page, allow_nil: true

    def menu_title
      page&.menu_title || url_label
    end
    
    def materialized_path
      page&.materialized_path || url
    end

    def url_and_url_label_presence
      if url.blank? && url_label.present?
        errors.add(:url, "can't be blank when URL label is present")
      elsif url.present? && url_label.blank?
        errors.add(:url_label, "can't be blank when URL is present")
      end
    end

    def url_or_page_presence
      if url.blank? && page_id.blank?
        errors.add(:url, "or page must be present")
      end
    end
  end
end
