module Spina
  class Part
    attr_accessor :name, :partable_type, :value

    def initialize(name, partable_type = nil)
      @name = name
      @partable_type = partable_type
    end

    def content
      value
    end

  end
end