module Spina
  class StructureItem < ApplicationRecord
    before_validation :ensure_position
    belongs_to :structure, optional: true
    has_many :structure_parts, dependent: :destroy

    validates_presence_of :position
    accepts_nested_attributes_for :structure_parts, allow_destroy: true

    def has_content?(structure_part)
      content(structure_part).present?
    end

    def content(structure_part)
      structure_parts.find_by(name: structure_part).try(:content)
    end

    def ensure_position
      self.position ||= Time.now.to_i
    end
  end
end
