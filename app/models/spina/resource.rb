module Spina
  class Resource < ApplicationRecord
    extend Mobility

    has_many :pages, dependent: :restrict_with_exception

    after_commit :update_resource_pages, on: [:update]

    translates :slug, backend: :jsonb

    def pages
      case order_by
      when "title"
        super.joins(:translations).where(spina_page_translations: {locale: I18n.locale}).order("spina_page_translations.title")
      when "created_at"
        super.order(:created_at)
      else
        super.order(:position)
      end
    end

    def update_resource_pages
      if previous_changes[:slug]
        ResourcePagesUpdateJob.perform_later(id)
      end
    end

    def order_by_options
      [
        [Spina::Page.human_attribute_name(:title), "title"],
        [Spina::Page.human_attribute_name(:created_at), "created_at"]
      ]
    end
  end
end
