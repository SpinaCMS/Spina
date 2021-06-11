module Spina
  class Resource < ApplicationRecord
    extend Mobility

    has_many :pages, dependent: :restrict_with_exception

    after_save :save_pages

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

    def save_pages
      PageUpdateJob.perform_later id
    end

  end
end