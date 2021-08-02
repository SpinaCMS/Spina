FactoryBot.define do
  factory :navigation, class: Spina::Navigation do
    name { "custom-nav" }
    label { "Custom nav" }
  end
  
  factory :navigation_item, class: Spina::NavigationItem do
    navigation
    page
  end
end
