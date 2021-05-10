module Spina
  class PartTest < ActiveSupport::TestCase
    def setup
      @base_part = FactoryBot.create :base_part
      @line_part = FactoryBot.create :line_part
    end

    test 'label returns nil with undefined content' do
      assert_nil @base_part.label
    end

    test 'label defaults to content#to_s' do
      assert_equal 'a line of text', @line_part.label
    end
  end
end