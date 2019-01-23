class RecipesList < ApplicationRecord
  has_many :recipes_list_recipes, dependent: :destroy
  has_many :recipes, through: :recipes_list_recipes
  belongs_to :user

  validates :name, :recipes, presence: true
end
