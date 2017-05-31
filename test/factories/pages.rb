FactoryGirl.define do
  factory :page, class: Spina::Page do
    draft false
    active true

    factory :homepage do
      name 'homepage'
      deletable false
    end

    factory :about_page do
      name 'about'
      deletable false
    end

    factory :demo_page do
      name 'demo'
      deletable true
      active false
    end

  end
end
