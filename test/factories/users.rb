FactoryGirl.define do
  factory :user, class: Spina::User do
    name  'Bram'
    email 'bram@denkgroot.com'
    password 'password'
    password_confirmation { password }
    admin true
  end
end
