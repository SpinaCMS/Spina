namespace :spina do

  desc "Generate all pages based on the theme config"
  task bootstrap: :environment do
    Spina::Account.first.save
  end

  desc "Seed content for demo theme"
  task :seed_demo_content do
    demo_theme = ::Spina::Theme.find_by_name('demo')
    if (page = Spina::Page.find_by(name: 'demo'))
      page.page_parts.clear
      parts = demo_theme.page_parts.map { |page_part| page.page_part(page_part) }
      parts.each do |part|
        case part.partable_type
        when 'Spina::Line' then part.partable.content = 'This is a single line'
        when 'Spina::Text' then part.partable.content = '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>'
        when 'Spina::Photo' then part.partable.remote_file_url = 'https://unsplash.it/300/200?random'
        when 'Spina::PhotoCollection'
          5.times { part.partable.photos.build(remote_file_url: 'https://unsplash.it/300/200?random') }
        when 'Spina::Color' then part.partable.content = '#6865b4'
        end
      end
      page.save
    end
  end

end
