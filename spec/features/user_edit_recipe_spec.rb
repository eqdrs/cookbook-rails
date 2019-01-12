require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@gmail.com', password: '123456')
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    RecipeType.create!(name: 'Entrada')
    cuisine = Cuisine.create!(name: 'Brasileira')
    Cuisine.create!(name: 'Arabe')
    Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)

    # simula a ação do usuário
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
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de chocolate')
    expect(page).to have_css('h3', text: 'Autor')
    expect(page).to have_css('p', text: user.email)
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'teste@gmail.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)

    # simula a ação do usuário
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
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'


    expect(page).to have_content('Você deve informar todos os dados da receita')
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

    expect(page).not_to have_link('Editar')
  end

  scenario 'and can\'t enter the edit route' do
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
    visit edit_recipe_path(recipe)

    expect(current_path).to eq root_path
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

    expect(page).not_to have_link('Editar')
  end
end
