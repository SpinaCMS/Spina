module Spina
  class Option < ApplicationRecord
    has_one :page_part, as: :page_partable
    has_one :layout_part, as: :layout_partable
    has_one :structure_part, as: :structure_partable

    def content
      I18n.t(['options',part.name,value].compact.join('.'))
    end

    private

    def part
      page_part || layout_part || structure_part
    end
  end
end
