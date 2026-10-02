module Spina
  module PartDefinitionMerge
    module_function

    def compatible?(left, right)
      left.slice(:part_type, :options, :item_name, :parts) == right.slice(:part_type, :options, :item_name, :parts)
    end

    def merge_metadata(existing, incoming)
      existing.dup.tap do |merged|
        merged[:title] ||= incoming[:title]
        merged[:hint] ||= incoming[:hint]
      end
    end
  end
end
