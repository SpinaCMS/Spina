module Spina::Embeds
  class Vimeo < Base
    attributes :url
    
    heroicon "video-camera"
    
    REGEX = /(https?:\/\/)?(www.)?(player.)?vimeo.com\/([a-z]*\/)*([0-9]{6,11})[?]?.*/
    
    validates :url, presence: true, format: {with: REGEX}
    
    def id
      REGEX.match(url).try(:[], 5)
    end
    
    # Get title from Vimeo API (remote call)
    def remote_title
      get_vimeo_json&.dig(0, "title")
    end
    
    def to_trix_partial_path
      "spina/embeds/vimeos/thumbnail"
    end
    
    private
    
      def get_vimeo_json
        uri = URI("https://vimeo.com/api/v2/video/#{id}.json")
        response = Net::HTTP.get(uri)
        begin
          JSON.parse(response)
        rescue
          nil
        end
      end
    
  end
end
