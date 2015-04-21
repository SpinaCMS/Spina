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

    def content
      structure_partable.try(:content) || structure_partable
    end

    def structure_partable_attributes=(attributes)
      if self.structure_partable.present?
        self.structure_partable.assign_attributes(attributes)
      else
        self.structure_partable = self.structure_partable_type.constantize.new(attributes)
      end
    end
  end
end