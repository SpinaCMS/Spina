module Spina
  class Embed
  
    class << self
  
      def all
        ::Spina::EMBEDS
      end
      
      def constantize(embeddable_type)
        return nil unless registered?(embeddable_type)
        embeddable_type.safe_constantize
      end
      
      def registered?(embeddable)
        all.map(&:to_s).include?(embeddable.to_s)
      end
  
      def register(*embeds)
        embeds.each{|embed| all << embed}
      end
  
    end
  
  
  end
end

