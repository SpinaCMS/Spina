module Spina::Embeds
  class Button < Base
    attributes :url, :label
    
    heroicon "cursor-click"
    
    validates :url, :label, presence: true
    
    def to_trix_partial_path
      "spina/embeds/buttons/trix_button"
    end
  end
end