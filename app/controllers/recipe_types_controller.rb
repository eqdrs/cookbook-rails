class RecipeTypesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :verify_admin, only: %i[new create edit update]

  def index
    @recipe_types = RecipeType.all
  end

  def show
    @recipe_type = RecipeType.find(params[:id])
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(recipe_type_params)
    if @recipe_type.save
      redirect_to @recipe_type
    else
      render :new
    end
  end

  def edit
    @recipe_type = RecipeType.find(params[:id])
  end

  def update
    @recipe_type = RecipeType.find(params[:id])
    if @recipe_type.update(recipe_type_params)
      redirect_to @recipe_type
    else
      render :edit
    end
  end

  private

  def verify_admin
    !current_user.admin && (redirect_to root_path)
  end

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end
