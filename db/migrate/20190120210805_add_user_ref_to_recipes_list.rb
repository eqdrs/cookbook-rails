class AddUserRefToRecipesList < ActiveRecord::Migration[5.2]
  def change
    add_reference :recipes_lists, :user, foreign_key: true
  end
end
