class CreateRecipesListRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes_list_recipes do |t|
      t.references :recipe, foreign_key: true
      t.references :recipes_list, foreign_key: true

      t.timestamps
    end
  end
end
