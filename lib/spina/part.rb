module Spina
  class Part

    class << self

      def all
        ::Spina::PARTS
      end

      def register(*parts)
        parts.each{|part| all << part}
      end

    end


  end
end

