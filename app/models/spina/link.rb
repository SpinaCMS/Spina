module Spina
  class Link < ApplicationRecord
    has_many :page_parts, as: :page_partable
    has_many :layout_parts, as: :layout_partable
    has_many :structure_parts, as: :structure_partable
    belongs_to :page

    delegate :materialized_path, to: :page
    alias link materialized_path

    def content
      self
    end

    private

    def part
      page_part || layout_part || structure_part
    end
  end
end
