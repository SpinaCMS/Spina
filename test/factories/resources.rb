FactoryBot.define do
  factory :resource, class: Spina::Resource do

    factory :breweries do
      name 'breweries'
      label 'Breweries'
    end

  end
end
