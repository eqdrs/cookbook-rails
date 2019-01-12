class RecipeType < ApplicationRecord
  has_many :recipes

  validates :name, presence: { message: "Você deve informar o nome do tipo de receita"}, uniqueness: { message: "Este tipo de receita já existe!", case_sensitive: false}
end
