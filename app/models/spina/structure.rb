module Spina
  class Structure < ActiveRecord::Base
    has_one :page_part, as: :page_partable
    has_many :structure_items

    accepts_nested_attributes_for :structure_items, allow_destroy: true
  end
end
