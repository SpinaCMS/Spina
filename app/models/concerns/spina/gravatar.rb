module Spina
  module Gravatar
    extend ActiveSupport::Concern

    def gravatar_url
      "https://www.gravatar.com/avatar/#{gravatar_hash}?d=#{fallback_url}"
    end

    private

    def fallback_url
      "https://eu.ui-avatars.com/api/#{CGI.escape(name)}/128"
    end

    def gravatar_hash
      Digest::MD5.hexdigest(email.to_s.strip.downcase)
    end
  end
end
