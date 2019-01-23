class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  belongs_to :user
  has_many :recipes_list_recipes, dependent: :destroy
  has_many :recipes_lists, through: :recipes_list_recipes
  has_one_attached :photo

  validates :title, :recipe_type, :cuisine, :difficulty,
            :cook_time, presence: true

  def cook_time_min
    "#{cook_time} minutos"
  end

  def author?(current_user)
    current_user == user
  end
end
