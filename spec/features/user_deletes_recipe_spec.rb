require 'rails_helper'

feature 'User deletes recipe' do
  scenario 'successfully' do
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create!(name: 'Brasileira')
    user = User.create!(email: 'teste@gmail.com', password: '123456')
    cake = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           user: user)
    
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    within("form#new_user") do
      click_on 'Entrar'
    end
    within("section#all-recipes") do
      click_on 'Bolo de cenoura'
    end
    click_on 'Apagar'

    expect(current_path).to eq root_path
    expect(page).to have_content('Receita apagada com sucesso!')
    expect(page).not_to have_content(cake.title)
  end

  scenario 'and must be logged in' do
    user = User.create!(email: 'teste@gmail.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)

    visit root_path
    within("section#all-recipes") do
      click_on 'Bolodecenoura'
    end

    expect(page).not_to have_link('Apagar')
  end

  scenario 'and must be the author' do
    author = User.create!(email: 'autor@gmail.com', password: '123456')
    user = User.create!(email: 'usuario@hotmail.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create!(name: 'Brasileira')
    recipe = Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: author)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    within("form#new_user") do
      click_on 'Entrar'
    end
    within("section#all-recipes") do
      click_on 'Bolodecenoura'
    end

    expect(page).not_to have_link('Apagar')
  end
end
