# frozen_string_literal: true

PageTemplate.define :show do
  title "Simple page"
  description "Default layout"
  usage "Use for your content"
  part :body, :text
  part :blogpost, :page_link, title: "Blogpost", options: {resource: "blog"}
  part :page, :page_link, title: "Pagina"
  repeater :testrepeater, title: "Testrepeater" do
    part :line, :line
    part :body, :text
  end
  part :page_group, :resource_link, title: "Pagegroup"
end
