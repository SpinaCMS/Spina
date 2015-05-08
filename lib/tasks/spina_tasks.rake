namespace :spina do
  desc "Generate basic pages"
  task bootstrap: [:create_account]

  desc "Create custom pages from spina config"
  task create_account: :environment do
    puts "Bootstrap Spina!"
    puts "Creating account..."
    Spina::Account.create name: 'Your Website', theme: 'Default'
    puts "Done"
  end
end