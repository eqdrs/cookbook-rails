require 'rails_helper'

feature 'User deletes recipe' do
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    cake = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
    visit root_path
    within("section#all-recipes") do
      click_on 'Bolo de cenoura'
    end
    click_on 'Apagar'

    expect(current_path).to eq root_path
    expect(page).to have_content('Receita apagada com sucesso!')
    expect(page).not_to have_content(cake.title)
  end
end
