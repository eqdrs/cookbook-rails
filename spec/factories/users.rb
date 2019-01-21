FactoryBot.define do
  factory :user do
    name { FFaker::NameBR.name }
    city { FFaker::AddressBR.city }
    email { FFaker::Internet.email }
    password { '12345678' }
    facebook { 'www.facebook.com' }
    twitter { 'www.twitter.com' }
  end
end
