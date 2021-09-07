require 'net/http'

module Spina::Embeds
  class Youtube < Base
    attributes :url
    
    heroicon "video-camera"
    
    REGEX = /(?:youtube(?:-nocookie)?\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})/
    
    validates :url, presence: true, format: {with: REGEX}
    
    def id
      REGEX.match(url).try(:[], 1)
    end
    
    # Get title from Youtube API (remote call)
    def remote_title
      get_youtube_json&.dig("title")
    end
    
    def to_trix_partial_path
      "spina/embeds/youtubes/thumbnail"
    end
    
    private
  
      def get_youtube_json
        uri = URI("https://www.youtube.com/oembed?url=http://youtube.com/watch?v=#{id}&format=json")
        response = Net::HTTP.get(uri)
        begin
          JSON.parse(response)
        rescue
          nil
        end
      end
      
  end
end