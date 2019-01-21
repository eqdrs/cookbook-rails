class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :verify_author, only: %i[edit update destroy]
  before_action :verify_admin, only: %i[highlight_recipe]

  def index
    @recipes = Recipe.all
    @recipe_types = RecipeType.all
  end

  def search
    @results = Recipe.where('title LIKE ?', "%#{params[:keyword]}%")
    @keyword = params[:keyword]
  end

  def show; end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
    else
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render :new
    end
  end

  def edit
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path, notice: 'Receita apagada com sucesso!'
  end

  def highlight_recipe
    @recipe = Recipe.find(params[:recipe_id])
    @recipe.toggle(:highlight).update(params.permit(:highlight))
    redirect_to @recipe
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def verify_author
    @recipe = Recipe.find(params[:id])
    @recipe.user.email != current_user.email && (redirect_to root_path)
  end

  def verify_admin
    (!current_user.admin) && (redirect_to root_path)
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :cook_method, :photo)
  end
end
