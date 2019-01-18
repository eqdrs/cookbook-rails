FactoryBot.define do
  factory :recipe do
    title { FFaker::Food.meat }
    recipe_type
    cuisine
    difficulty { 'Médio' }
    cook_time { 60 }
    ingredients { FFaker::Food.vegetable }
    cook_method { 'Misture e coloque no forno.' }
    user
  end
end
