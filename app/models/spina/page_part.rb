module Spina
  class PagePart < ApplicationRecord
    include Part
    include Optionable

    belongs_to :page, inverse_of: :page_parts
    belongs_to :page_partable, polymorphic: true, optional: true

    accepts_nested_attributes_for :page_partable, allow_destroy: true

    validates :name, uniqueness: {scope: :page_id}

    alias_attribute :partable, :page_partable
    alias_attribute :partable_id, :page_partable_id
    alias_attribute :partable_type, :page_partable_type
    alias_method :page_partable_attributes=, :partable_attributes=

    def position(theme)
      page.view_template_config(theme)[:page_parts].index { |page_part| page_part == self.name }.to_i
    end
  end
end
