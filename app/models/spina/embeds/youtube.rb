module Spina::Embeds
  class Youtube < Base
    attributes :url
    
    heroicon "video-camera"
    
    REGEX = /(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/
    
    validates :url, presence: true, format: {with: REGEX}
    
    def id
      REGEX.match(url).try(:[], 1)
    end
    
    def to_trix_partial_path
      "spina/embeds/youtubes/thumbnail"
    end
  end
end
