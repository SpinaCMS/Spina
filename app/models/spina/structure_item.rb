module Spina
  class StructureItem < ApplicationRecord
    belongs_to :structure
    has_many :structure_parts, dependent: :destroy

    scope :sorted_by_structure, -> { order('position') }

    accepts_nested_attributes_for :structure_parts, allow_destroy: true

    def content(structure_part)
      structure_parts.find_by(name: structure_part).try(:content)
    end
  end
end