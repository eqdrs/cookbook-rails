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

  describe 'POST' do
    it 'register new recipe succesfully' do
      recipe_type = create(:recipe_type)
      cuisine = create(:cuisine)
      user = create(:user)

      post '/api/v1/recipes/new', params: { recipe:
                                            { title: 'Tabule',
                                              recipe_type_id: recipe_type.id,
                                              cuisine_id: cuisine.id,
                                              difficulty: 'Médio',
                                              cook_time: 30,
                                              ingredients: 'Trigo e cebola',
                                              cook_method: 'Misturar tudo.',
                                              user_id: user.id } }

      hash = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include 'Receita cadastrada com sucesso!'
      expect(hash['recipe']['title']).to eq 'Tabule'
      expect(hash['recipe']['recipe_type_id']).to eq recipe_type.id
      expect(hash['recipe']['cuisine_id']).to eq cuisine.id
      expect(hash['recipe']['difficulty']).to eq 'Médio'
      expect(hash['recipe']['cook_time']).to eq 30
      expect(hash['recipe']['ingredients']).to eq 'Trigo e cebola'
      expect(hash['recipe']['cook_method']).to eq 'Misturar tudo.'
      expect(hash['recipe']['user_id']).to eq user.id
      expect(Recipe.count).to eq 1
    end

    it 'must enter required params' do
      user = create(:user)

      post '/api/v1/recipes/new', params: { recipe:
                                            { title: '',
                                              recipe_type_id: '',
                                              cuisine_id: '',
                                              difficulty: '',
                                              cook_time: '',
                                              ingredients: '',
                                              cook_method: '',
                                              user_id: user.id } }

      expect(response).to have_http_status(:precondition_failed)
      expect(response.body).to include 'Você deve informar todos os campos!'
      expect(Recipe.count).to eq 0
    end

    it 'must be valid user' do
      recipe_type = create(:recipe_type)
      cuisine = create(:cuisine)

      post '/api/v1/recipes/new', params: { recipe:
                                            { title: 'Tabule',
                                              recipe_type_id: recipe_type.id,
                                              cuisine_id: cuisine.id,
                                              difficulty: 'Médio',
                                              cook_time: 30,
                                              ingredients: 'Trigo e cebola',
                                              cook_method: 'Misturar tudo.',
                                              user_id: 1 } }

      expect(response).to have_http_status(:precondition_failed)
      expect(response.body).to include 'Usuário inválido!'
      expect(Recipe.count).to eq 0
    end
  end

  describe 'PATCH' do
    it 'user edits recipe successfully' do
      recipetype = create(:recipe_type)
      cuisine = create(:cuisine)
      recipe = create(:recipe, title: 'Feijoada')

      patch '/api/v1/recipes/1/edit', params: { recipe:
                                                { title: 'Tabule',
                                                  recipe_type_id: recipetype.id,
                                                  cuisine_id: cuisine.id,
                                                  difficulty: 'Muito difícil',
                                                  cook_time: 30,
                                                  ingredients: 'Trigo e cebola',
                                                  cook_method: 'Misturar tudo.',
                                                  user_id: recipe.user.id } }

      hash = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include 'Receita atualizada com sucesso!'
      expect(hash['recipe']['title']).to eq 'Tabule'
      expect(hash['recipe']['recipe_type_id']).to eq recipetype.id
      expect(hash['recipe']['cuisine_id']).to eq cuisine.id
      expect(hash['recipe']['difficulty']).to eq 'Muito difícil'
      expect(hash['recipe']['cook_time']).to eq 30
      expect(hash['recipe']['ingredients']).to eq 'Trigo e cebola'
      expect(hash['recipe']['cook_method']).to eq 'Misturar tudo.'
      expect(hash['recipe']['user_id']).to eq recipe.user.id
    end

    it 'user must enter required params' do
      create(:recipe)

      patch '/api/v1/recipes/1/edit', params: { recipe:
                                                { title: '',
                                                  recipe_type_id: '',
                                                  cuisine_id: '',
                                                  difficulty: '',
                                                  cook_time: '',
                                                  ingredients: '',
                                                  cook_method: '',
                                                  user_id: '' } }

      expect(response).to have_http_status(:precondition_failed)
      expect(response.body).to include 'Você deve informar todos os campos!'
    end

    it 'recipe must be valid' do
      recipetype = create(:recipe_type)
      cuisine = create(:cuisine)
      user = create(:user)

      patch '/api/v1/recipes/1/edit', params: { recipe:
                                                { title: 'Tabule',
                                                  recipe_type_id: recipetype.id,
                                                  cuisine_id: cuisine.id,
                                                  difficulty: 'Muito difícil',
                                                  cook_time: 30,
                                                  ingredients: 'Trigo e cebola',
                                                  cook_method: 'Misturar tudo.',
                                                  user_id: user.id } }

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include 'Receita inexistente!'
    end
  end
end
