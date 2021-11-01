module Spina::Embeds
  class Snippet < Base
    attributes :text
    
    heroicon "template"
    
    validates :text, presence: true
    
    def to_trix_partial_path
      "spina/embeds/snippets/trix_snippet"
    end
  end
end