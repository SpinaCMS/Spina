module Spina
  class Text < ActiveRecord::Base
    has_many :page_parts, as: :page_partable
    has_many :layout_parts, as: :layout_partable
  end
end
