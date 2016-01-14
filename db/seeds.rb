puts "Seeding #{__FILE__} from Spina::Engine"

current_theme = ::Spina.themes.detect{ |theme| theme.name == Spina::Account.first.theme }
if (page = Spina::Page.find_by(name: 'demo'))
  page.page_parts.clear
  parts = current_theme.config.page_parts.map { |page_part| page.page_part(page_part) }
  parts.each do |part|
    case part.partable_type
    when 'Spina::Line' then part.partable.content = 'This is a single line'
    when 'Spina::Text' then part.partable.content = '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>'
    when 'Spina::Photo' then part.partable.remote_file_url = 'https://unsplash.it/300/200?random'
    when 'Spina::PhotoCollection'
      5.times { part.partable.photos.build(remote_file_url: 'https://unsplash.it/300/200?random') }
    # when 'Spina::Structure'
    #   part.partable.structure_items.build({ name: 'title', title: 'Title', structure_partable_type: 'Spina::Line' })
    #   part.partable.structure_items.build({ name: 'description', title: 'Description', structure_partable_type:  'Spina::Text' })
    when 'Spina::Color' then part.partable.content = '#6865b4'
    end
  end
  page.save
end
