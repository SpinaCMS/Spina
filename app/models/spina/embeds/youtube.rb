module Spina::Embeds
  class Youtube < Base
    attributes :id, :title
    
    validates :id, :title, presence: true
    
    def to_trix_partial_path
      "spina/embeds/youtubes/thumbnail"
    end
  end
end