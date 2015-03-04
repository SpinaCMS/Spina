puts "Seeding #{__FILE__} from Spina::Engine"

Spina::User.destroy_all
Spina::User.create name: "Bram", email: "bram@denkgroot.com", password: "spina", password_confirmation: "spina", admin: true

Spina::Account.destroy_all
Spina::Account.create name: "Website"

Spina::Page.destroy_all

Spina::Photo.destroy_all
['after sun 2', 'after sun', 'amygdalus', 'at sunset-1', 'colorfull', 'nature tree', 'orchid', 'smooth', 'soft', 'spring memory', 'spring purple', 'spring', 'yew-tree'].each do |image|
  Spina::Photo.create({ file:  File.open(File.join(Spina::Engine.root, "test/support/images/#{image}.jpg")) })
end