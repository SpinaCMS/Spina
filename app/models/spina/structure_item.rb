module Spina
  class StructureItem < ApplicationRecord
    include Spina::Partable

    before_validation :ensure_position
    belongs_to :structure, optional: true
    has_many :structure_parts, dependent: :destroy

    scope :sorted_by_structure, -> { order(:position) }

    validates_presence_of :position
    accepts_nested_attributes_for :structure_parts, allow_destroy: true

    alias_attribute :parts, :structure_parts

    def has_content?(options)
      content(options).present?
    end

    def content(options)
      part(options).try(:content)
    end

    def ensure_position
      self.position ||= Time.now.to_i
    end
  end
end
