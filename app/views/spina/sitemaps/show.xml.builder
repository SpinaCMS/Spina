xml.instruct!

xml.urlset "xmlns" => "http://www.google.com/schemas/sitemap/0.84" do
  xml.url do
    xml.loc "http://#{request.host}/"
    xml.lastmod Time.now.to_s(:w3c)
    xml.changefreq "always"
  end

  @pages.each do |page|
    xml.url do
      xml.loc "http://#{request.host}#{page.materialized_path}"
      xml.lastmod page.updated_at.to_date
      xml.changefreq "weekly"
      xml.priority 0.9
    end
  end
end