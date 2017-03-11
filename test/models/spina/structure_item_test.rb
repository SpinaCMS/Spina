require 'test_helper'

module Spina
  class StructureItemTest < ActiveSupport::TestCase

    def setup
      @structure_1 = spina_structures(:structure_1)

      @structure_item_1 = spina_structure_items(:structure_item_1)
      @structure_item_2 = spina_structure_items(:structure_item_2)

      @structure_part_1 = spina_structure_parts(:structure_part_1)
    end

    test 'structure_item_1 content' do
      assert_equal 'line_content_1', @structure_item_1.content(@structure_part_1.name)
    end

    test 'structure_item_2 content' do
      assert_nil @structure_item_2.content(@structure_part_1.name)
    end

    test 'structure_item_1 position' do
      assert_nil @structure_item_1.position
      @structure_item_1.save!
      refute_nil @structure_item_1.position
    end
  end
end
