class DropRecipesRecipesLists < ActiveRecord::Migration[5.2]
  def change
    drop_table :recipes_recipes_lists
  end
end
