class Api::V1::RecipesController < Api::V1::ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  before_action :set_recipe, only: %i[show update destroy]
  before_action :verify_params, only: %i[create update]
  before_action :basic_authentication, only: %i[create update destroy]

  def index
    last_recipes = Recipe.all.last(6)
    render json: last_recipes
  end

  def show
    return render json: @recipe unless @recipe.nil?

    render json: { text: 'Receita inexistente!' }, status: :not_found
  end

  def create
    recipe = Recipe.new(recipe_params)
    recipe.user = @user
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
    render json: { recipe_types: recipe_types, cuisines: cuisines }
  end

  private

  def verify_params
    params[:recipe].is_a?(String) &&
      (params[:recipe] = ActionController::Parameters.new(eval params[:recipe]))
  end

  def set_recipe
    @recipe = Recipe.find_by('id = ?', params[:id])
    @recipe.nil? && (return render json: { text: 'Receita inválida!' },
                                   status: :not_found)
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :cook_method)
  end

  def basic_authentication
    authenticate_with_http_basic do |email, password|
      @user = User.find_by(email: email)
      (!@user.nil? && @user.valid_password?(password)) && (return true)
      request_http_basic_authentication
    end
  end
end
