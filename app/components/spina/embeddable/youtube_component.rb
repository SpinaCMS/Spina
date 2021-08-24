module Spina
  module Embeddable
    class YoutubeComponent < ApplicationComponent
      attr_reader :attributes
    
      def initialize(attributes)
        @attributes = attributes
      end
      
      def youtube_id
        attributes["data-youtube-id"]
      end
      
      def call
        <<-HTML
          <iframe id="ytplayer" type="text/html" width="640" height="360" src="https://www.youtube.com/embed/#{youtube_id}" frameborder="0"></iframe>
        HTML
      end
      
    end
  end
end