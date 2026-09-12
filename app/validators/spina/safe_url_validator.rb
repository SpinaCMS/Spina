module Spina
  # Validates that a user-supplied URL is safe to render as the href of a link.
  #
  # Relative URLs (paths, anchors, query strings and protocol-relative URLs) and
  # absolute URLs using one of the allowed schemes pass validation. Anything else,
  # most notably javascript:, data: and vbscript: URIs, is rejected to prevent
  # stored XSS when the URL is rendered with link_to.
  #
  #   validates_with Spina::SafeUrlValidator, attributes: [:url]
  #   validates_with Spina::SafeUrlValidator, attributes: [:url], schemes: %w[https]
  class SafeUrlValidator < ActiveModel::EachValidator
    ALLOWED_SCHEMES = %w[http https mailto tel].freeze

    # A URL scheme as parsed by browsers (WHATWG URL Standard): an ASCII letter
    # followed by ASCII letters, digits, "+", "-" or ".", terminated by a colon.
    SCHEME = /\A([a-z][a-z0-9+\-.]*):/i

    # Browsers strip leading and trailing C0 controls and spaces, and remove all
    # tabs and newlines before parsing a URL, so "java\nscript:" would still run.
    LEADING_OR_TRAILING_C0_CONTROL_OR_SPACE = /\A[\x00-\x20]+|[\x00-\x20]+\z/
    TAB_OR_NEWLINE = /[\t\n\r]/

    def validate_each(record, attribute, value)
      return if safe?(value)

      record.errors.add(attribute, :unsafe_url, **options.except(:schemes).merge(value: value))
    end

    private

    def safe?(value)
      scheme = scheme_of(value)
      scheme.nil? || allowed_schemes.include?(scheme)
    end

    def scheme_of(value)
      url = value.to_s.gsub(LEADING_OR_TRAILING_C0_CONTROL_OR_SPACE, "").gsub(TAB_OR_NEWLINE, "")
      match = SCHEME.match(url)
      match[1].downcase if match
    end

    def allowed_schemes
      Array(options.fetch(:schemes, ALLOWED_SCHEMES)).map(&:to_s)
    end
  end
end
