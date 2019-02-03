class Api::V1::RecipesController < Api::V1::ApplicationController
  before_action :validate_user, only: %i[create]
  before_action :validate_recipe, only: %i[update]
  def show
    recipe = Recipe.find_by('id = ?', params[:id])
    return render json: recipe unless recipe.nil?

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
    recipe = Recipe.find_by('id = ?', params[:id])
    if recipe.update(recipe_params)
      render json: { recipe: recipe, text: 'Receita atualizada com sucesso!' }
    else
      render json: { text: 'Você deve informar todos os campos!' },
             status: :precondition_failed
    end
  end

  private

  def validate_user
    user = User.find_by('id = ?', params[:recipe][:user_id])
    user.nil? && (return render json: { text: 'Usuário inválido!' },
                                status: :precondition_failed)
  end

  def validate_recipe
    recipe = Recipe.find_by('id = ?', params[:id])
    recipe.nil? && (return render json: { text: 'Receita inexistente!' },
                                  status: :not_found)
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :cook_method, :user_id)
  end
end
