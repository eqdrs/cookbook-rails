class RecipesListRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :recipes_list
end
