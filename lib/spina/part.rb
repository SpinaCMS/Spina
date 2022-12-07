module Spina
  class Part
    class << self
      def all
        ::Spina::PARTS
      end

      def register(*parts)
        parts.each do |part|
          unregister(part)
          all << part
        end
      end

      def unregister(part)
        all.delete_if do |registered_part|
          registered_part.name == part.name
        end
      end
    end
  end
end
