module Spina
  class Structure < ApplicationRecord
    has_one :page_part, as: :page_partable
    has_many :structure_items

    after_save -> { structure_items.each(&:save) }

    accepts_nested_attributes_for :structure_items, allow_destroy: true

    def content
      self
    end

    def content_as_json
      structure_items.map(&:content_as_json)
    end

  end
end
