FactoryBot.define do
  factory :page, class: Spina::Page do
    draft false
    active true

    factory :homepage do
      name 'homepage'
      title 'Homepage'
      deletable false
    end

    factory :about_page do
      name 'about'
      title 'About'
      deletable false
    end

    factory :demo_page do
      name 'demo'
      title 'Demo'
      deletable true
      active false
    end

  end
end
