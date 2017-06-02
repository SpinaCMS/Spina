module Spina
  module Partable
    def part(part)
      options = part[:options]
      part = parts.where(name: part[:name]).first || parts.build(part)
      part.options = options unless part.options
      part.partable = part.partable_type.constantize.new unless part.partable.present?
      part
    end
  end
end
