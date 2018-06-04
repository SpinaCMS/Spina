FactoryBot.define do
  factory :account, class: Spina::Account do
    name 'My Website'
    email 'bram@spinacms.com'
    preferences { { theme: 'demo' } }
  end
end
