module Spina::Embeds
  class Button < Base
    attributes :url, :label, :style
    
    heroicon "cursor-click"
    
    validates :url, :label, :style, presence: true
    
    def to_trix_partial_path
      "spina/embeds/buttons/trix_button"
    end
  end
end