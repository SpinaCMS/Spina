FactoryGirl.define do
  factory :structure_part, class: Spina::StructurePart do
    structure_item
    association :structure_partable, factory: :line
    sequence(:name) { |n| "name_#{n}"}
    sequence(:title) { |t| "title_#{t}"}
  end
end
