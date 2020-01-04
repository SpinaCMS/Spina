module Spina
  class Resource < ApplicationRecord
    has_many :pages, dependent: :restrict_with_exception

    belongs_to :parent_page, class_name: "Spina::Page", optional: true

    after_save :scope_pages_to_parent_page

    def pages
      case order_by
      when "title"
        super.joins(:translations).where(spina_page_translations: {locale: I18n.locale}).order("spina_page_translations.title")
      else
        super.order(created_at: :desc)
      end
    end

    private

      def scope_pages_to_parent_page
        pages.roots.each do |root_page|
          root_page.update(parent: parent_page)
        end
      end

  end
end