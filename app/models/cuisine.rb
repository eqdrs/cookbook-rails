class Cuisine < ApplicationRecord
  has_many :recipes

  validates :name, presence: { message: "Você deve informar o nome da cozinha"}, uniqueness: { message: "Esta cozinha já existe!", case_sensitive: false}
end
