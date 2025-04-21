FactoryBot.define do
  factory :user, class: "Spina::User" do
    name { "Bram" }
    email { "bram@denkgroot.com" }
    password { "4Jvp9TUGoYrt2cXyrRpK_vsPd4J7" }
    password_confirmation { password }
    admin { true }
  end
end
