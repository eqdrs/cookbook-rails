class Api::V1::RecipesController < Api::V1::ApplicationController
  before_action :set_recipe, only: %i[show update destroy validate_recipe]
  before_action :validate_recipe, only: %i[update destroy]

  def index
    last_recipes = Recipe.all.last(3)
    render json: last_recipes
  end

  def show
    return render json: @recipe unless @recipe.nil?

    render json: { text: 'Receita inexistente!' }, status: :not_found
  end

  def create
    recipe = Recipe.new(recipe_params)
    if recipe.save
      render json: { recipe: recipe, text: 'Receita cadastrada com sucesso!' }
    else
      render json: { text: 'Você deve informar todos os campos!' },
             status: :precondition_failed
    end
  end

  def update
    if @recipe.update(recipe_params)
      render json: { recipe: @recipe, text: 'Receita atualizada com sucesso!' }
    else
      render json: { text: 'Você deve informar todos os campos!' },
             status: :precondition_failed
    end
  end

  def destroy
    @recipe.destroy
    render json: { text: 'Receita apagada com sucesso!' }
  end

  def form_data
    recipe_types = RecipeType.all
    cuisines = Cuisine.all
    users = User.all
    render json: {recipe_types: recipe_types, cuisines: cuisines,
                  users: users }
  end

  private

  def set_recipe
    @recipe = Recipe.find_by('id = ?', params[:id])
  end

  def validate_recipe
    @recipe.nil? && (return render json: { text: 'Receita inválida!' },
                                   status: :not_found)
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :cook_method, :user_id)
  end
end
