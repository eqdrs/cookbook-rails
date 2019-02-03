require 'rails_helper'

RSpec.describe 'Recipes API' do
  describe 'GET' do
    it 'should get a valid recipe' do
      recipe = create(:recipe)

      get '/api/v1/recipes/1'

      received_recipe = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(received_recipe['title']).to eq recipe.title
      expect(received_recipe['difficulty']).to eq recipe.difficulty
      expect(received_recipe['cook_time']).to eq recipe.cook_time
      expect(received_recipe['ingredients']).to eq recipe.ingredients
      expect(received_recipe['cook_method']).to eq recipe.cook_method
    end

    it 'nonexistent recipe' do
      get '/api/v1/recipes/1'

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include 'Receita inexistente!'
    end
  end
end
