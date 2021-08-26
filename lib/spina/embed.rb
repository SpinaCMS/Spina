module Spina
  class Embed
  
    class << self
  
      def all
        ::Spina::EMBEDS
      end
      
      def registered?(embeddable)
        all.include?(embeddable)
      end
  
      def register(*embeds)
        embeds.each{|embed| all << embed}
      end
  
    end
  
  
  end
end

