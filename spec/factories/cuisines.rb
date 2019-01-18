FactoryBot.define do
  factory :cuisine do
    name { FFaker::AddressUS.city }
  end
end
