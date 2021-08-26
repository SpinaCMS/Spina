module Spina::Embeds
  class Vimeo < Base
    attributes :id
    
    def to_trix_partial_path
      "spina/embeds/vimeos/thumbnail"
    end
  end
end