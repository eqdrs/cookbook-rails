FactoryBot.define do
  factory :recipe_type do
    sequence(:name) { |n| "Main Dish#{n}" }
  end
end
