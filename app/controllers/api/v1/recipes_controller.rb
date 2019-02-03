class Api::V1::RecipesController < Api::V1::ApplicationController
  def show
    recipe = Recipe.find_by('id = ?', params[:id])
    return render json: recipe unless recipe.nil?

    render json: { text: 'Receita inexistente!' }, status: :not_found
  end
end
