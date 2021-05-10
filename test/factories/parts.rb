FactoryBot.define do
  factory :base_part, class: Spina::Parts::Base do
    skip_create

    factory :line_part, class: Spina::Parts::Line do
      content { 'a line of text' }
    end
  end
end