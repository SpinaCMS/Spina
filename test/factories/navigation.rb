FactoryBot.define do
  factory :navigation, class: "Spina::Navigation" do
    name { "custom-nav" }
    label { "Custom nav" }
  end

  factory :navigation_item, class: "Spina::NavigationItem" do
    association :page, title: "A page"
    kind { "page" }
    navigation
  end
end
