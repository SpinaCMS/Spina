FactoryBot.define do
  factory :page, class: 'Spina::Page' do
    draft { false }
    active { true }
    json_attributes { { 'themes' => ['demo'] } }

    # UPDATE
    # to include #is_homepage
    # and #json_attributes
    factory :homepage do
      name { 'homepage' }
      title { 'Homepage' }
      is_homepage { true }
      json_attributes { { 'themes' => ['demo'], 'homepage_for_themes' => ['demo'] } }
      deletable { false }
    end

    factory :about_page do
      name { "about" }
      title { "About" }
      deletable { false }
    end

    factory :services_page do
      title { "Services" }
    end

    factory :demo_page do
      name { "demo" }
      title { "Demo" }
      deletable { true }
      active { false }
    end

    factory :child_page do
      title { "Child page" }
    end
  end
end
