module Spina
  class StructureItem < ApplicationRecord
    include Partable

    before_validation :ensure_position
    belongs_to :structure, optional: true
    has_many :structure_parts, dependent: :destroy

    scope :sorted_by_structure, -> { order(:position) }

    after_save -> { structure_parts.each(&:save) }

    validates_presence_of :position
    accepts_nested_attributes_for :structure_parts, allow_destroy: true

    alias_attribute :parts, :structure_parts

    def ensure_position
      self.position ||= Time.now.to_i
    end

    def content_as_json
      structure_parts.map do |structure_part|
        { structure_part.name => structure_part.content_as_json }
      end.inject(:merge)
    end
  end
end
