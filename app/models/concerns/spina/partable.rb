module Spina
  module Partable
    def part(part)
      part = parts.where(name: part[:name]).first || parts.build(part)
      part.partable = part.partable_type.constantize.new unless part.partable.present?
      part
    end
  end
end