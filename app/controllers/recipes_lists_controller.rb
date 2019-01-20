class RecipesListsController < ApplicationController
  def show
    @recipes_list = RecipesList.find(params[:id])
  end

  def new
    @recipes_list = RecipesList.new
    @recipes = Recipe.all
  end

  def create
    @recipes_list = RecipesList.new(recipes_list_params)
    @recipes_list.user = current_user
    if @recipes_list.save
      redirect_to @recipes_list
    else
      @recipes = Recipe.all
      render :new
    end
  end

  private

  def recipes_list_params
    params.require(:recipes_list).permit(:name, :user_id, recipe_ids: [])
  end
end
