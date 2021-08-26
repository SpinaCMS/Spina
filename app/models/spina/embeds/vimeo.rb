module Spina::Embeds
  class Vimeo < Base
    attributes :id
    
    def to_trix_partial_path
      "spina/embeds/youtubes/thumbnail"
    end
  end
end