xml.instruct!

xml.urlset "xmlns" => "http://www.google.com/schemas/sitemap/0.9", "xmlns:xhtml" => "http://www.w3.org/1999/xhtml" do
  @pages.each do |page|
    xml.url do
      xml.loc "#{request.protocol}#{request.host}#{page.materialized_path}"

      # Translations
      page.translations.each do |translation|
        if translation.locale.in? Spina.config.locales
          Globalize.with_locale(translation.locale) do
            xml.xhtml(:link, rel: "alternate", hreflang: translation.locale, href: "#{request.protocol}#{request.host}#{page.materialized_path}")
          end
        end
      end

      xml.lastmod page.updated_at.to_date
      xml.changefreq "weekly"
      xml.priority 0.9
    end
  end
end