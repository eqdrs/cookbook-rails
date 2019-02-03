class Api::V1::RecipesController < Api::V1::ApplicationController
  def show
    recipe = Recipe.find_by('id = ?', params[:id])
    return render json: recipe unless recipe.nil?

    render json: { text: 'Receita inexistente!' }, status: :not_found
  end

  def create
    recipe = Recipe.new(recipe_params)
    user = User.find_by('id = ?', params[:recipe][:user_id])
    if user.nil?
      render json: { text: 'Usuário inválido!' }, status: :precondition_failed
    elsif recipe.save
      render json: { recipe: recipe, text: 'Receita cadastrada com sucesso!' }
    else
      render json: { text: 'Você deve informar todos os campos!' },
             status: :precondition_failed
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id,
                                   :difficulty, :cook_time, :ingredients,
                                   :cook_method, :user_id)
  end
end
