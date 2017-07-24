module Spina
  class LayoutPart < ApplicationRecord
    include Part
    include Optionable

    belongs_to :account
    belongs_to :layout_partable, polymorphic: true

    accepts_nested_attributes_for :layout_partable, allow_destroy: true

    validates_uniqueness_of :name, scope: :account_id

    alias_attribute :partable, :layout_partable
    alias_attribute :partable_type, :layout_partable_type
    alias_method :layout_partable_attributes=, :partable_attributes=

    def position(theme)
      layout_parts = theme.layout_template[:layout_parts]
      layout_parts.index { |layout_part| layout_part == self.name }.to_i
    end
  end
end
