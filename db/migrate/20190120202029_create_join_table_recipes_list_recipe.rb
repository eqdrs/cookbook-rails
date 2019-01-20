class CreateJoinTableRecipesListRecipe < ActiveRecord::Migration[5.2]
  def change
    create_join_table :recipes_lists, :recipes do |t|
      # t.index [:recipes_list_id, :recipe_id]
      # t.index [:recipe_id, :recipes_list_id]
    end
  end
end
