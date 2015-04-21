module Spina
  class StructureItem < ActiveRecord::Base
    belongs_to :structure
    has_many :structure_parts, dependent: :destroy

    scope :sorted_by_structure, -> { order('position') }

    accepts_nested_attributes_for :structure_parts, allow_destroy: true
  end
end