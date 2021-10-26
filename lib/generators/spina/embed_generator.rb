module Spina
  class EmbedGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("../templates", __FILE__)
    
    argument :attributes, type: :array, default: [], banner: "field field"
    
    def create_embed_object
      template "app/models/spina/embeds/embed.rb.tt", "app/models/spina/embeds/#{file_name}.rb"
    end
    
    def create_views
      template "app/views/spina/embeds/_fields.html.erb.tt", "app/views/spina/embeds/#{file_name}/_fields.html.erb"
      
      template "app/views/spina/embeds/_partial.html.erb.tt", "app/views/spina/embeds/#{file_name}/_partial.html.erb"
      
      template "app/views/spina/embeds/_trix_partial.html.erb.tt", "app/views/spina/embeds/#{file_name}/_trix_partial.html.erb"
    end
    
  end
end