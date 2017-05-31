FactoryGirl.define do
  factory :line, class: Spina::Line do
    sequence(:content) { |c| "content_#{c}"}
  end
end
