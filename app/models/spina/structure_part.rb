module Spina
  class StructurePart < ActiveRecord::Base
    belongs_to :structure_item
    belongs_to :structure_partable, polymorphic: true

    accepts_nested_attributes_for :structure_partable, allow_destroy: true

    validates_presence_of :name, :structure_partable_type, :title
    validates_uniqueness_of :name, scope: :structure_item_id

    scope :sorted, -> { order(:position) }

    def to_s
      name
    end
  end
end