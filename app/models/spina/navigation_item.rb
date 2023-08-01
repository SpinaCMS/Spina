module Spina
  class NavigationItem < ApplicationRecord
    extend Mobility
    belongs_to :navigation, touch: true, class_name: "Spina::Navigation"
    belongs_to :page, optional: true, class_name: "Spina::Page"
    
    before_validation do
      if page_kind?
        self.url = nil
        self.translations.each { |translation| translation.url_title = nil }
      else
        self.page = nil
      end
    end

    has_ancestry

    enum(:kind, 
      {
        page: "page",
        url: "url"
      }, 
      default: :page, 
      suffix: true
    )

    scope :regular_pages, -> { joins(:page).where(spina_pages: {resource_id: nil}) }
    scope :sorted, -> { order("spina_navigation_items.position") }
    scope :live, -> { joins(:page).where(spina_pages: {draft: false, active: true}) }
    scope :in_menu, -> { joins(:page).where(spina_pages: {show_in_menu: true}) }
    scope :active, -> { joins(:page).where(spina_pages: {active: true}) }
    scope :urls, -> { all.select {|i| i.url_kind?} }

    with_options if: :page_kind? do
      validates :page, uniqueness: {scope: :navigation}, presence: true
    end

    with_options if: :url_kind? do
      validates :url, presence: true
      validates :url_title, presence: true
    end

    translates :url_title

    delegate :draft?, :homepage?, to: :page, allow_nil: true

    def menu_title
      page_kind? ? page&.menu_title : url_title
    end
    
    def materialized_path
      page_kind? ? page&.materialized_path : url
    end
  end
end
