require 'test_helper'

module Spina
  class StructureItemTest < ActiveSupport::TestCase

    def setup
      @structure_part = FactoryGirl.create :structure_part
      @item = @structure_part.structure_item
      @partable = @structure_part.structure_partable

      @structure_part_2 = FactoryGirl.create :structure_part
      @item_2 = @structure_part_2.structure_item
      @partable_2 = @structure_part_2.structure_partable
    end

    test 'structure_item content' do
      assert_equal @partable.content, @item.content(@structure_part.name)
    end

    test 'structure item unable to receive content for unassociated part' do
      assert_nil @item_2.content(@structure_part.name)
    end

    test 'structure_item position' do
      refute_nil @item.position
    end
  end
end
