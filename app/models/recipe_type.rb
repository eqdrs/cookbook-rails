class RecipeType < ApplicationRecord
  has_many :recipes, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
