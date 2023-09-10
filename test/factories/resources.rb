FactoryBot.define do
  factory :resource, class: "Spina::Resource" do
    name { "resource" }
    label { "Resource" }

    factory :breweries do
      name { "breweries" }
      label { "Breweries" }
    end
  end
end
