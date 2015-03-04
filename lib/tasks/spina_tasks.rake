namespace :spina do
  desc "Generate basic pages"
  task bootstrap: [:create_basic_pages]

  desc "Create custom pages from spina config"
  task :create_basic_pages => :environment do
    puts "Bootstrap Spina!"
    puts "Creating Homepage..."
    Spina::Page.where(name: 'homepage').where(deletable: false).first_or_create!
    puts "Done"
  end
end
