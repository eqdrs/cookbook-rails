require 'rails_helper'

feature 'Visitor search recipe' do
  scenario 'and find only one recipe' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    cake = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    pudding = Recipe.create(title: 'Pudim', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Fácil',
                           cook_time: 60,
                           ingredients: 'Leite condensado, açúcar',
                           cook_method: 'Misture e coloque no forno.')
    
    visit root_path
    fill_in 'Busca', with: 'Pudim'
    click_on 'Buscar'

    expect(page).not_to have_content(cake.title)

    expect(page).to have_css('h1', text: 'Resultados da busca para: Pudim')
    expect(page).to have_css('h2', text: '1 receita(s) encontrada(s)')
    expect(page).to have_content(pudding.title)
    expect(page).to have_css('li', text: pudding.recipe_type.name)
    expect(page).to have_css('li', text: pudding.cuisine.name)
    expect(page).to have_css('li', text: pudding.difficulty)
    expect(page).to have_css('li', text: "#{pudding.cook_time} minutos") 
  end

  scenario 'and finds nothing' do
    visit root_path
    fill_in 'Busca', with: 'Pudim'
    click_on 'Buscar'

    expect(page).to have_content('Resultados da busca para: Pudim')
    expect(page).to have_content('Nenhuma receita encontrada.')
  end

  scenario 'and finds more the one recipe' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    carrot_cake = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    orange_cake = Recipe.create(title: 'Bolo de laranja', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, laranjas, açúcar',
                           cook_method: 'Misture e coloque no forno.')

    visit root_path
    fill_in 'Busca', with: 'Bolo'
    click_on 'Buscar'

    expect(page).to have_css('h1', text: 'Resultados da busca para: Bolo')
    expect(page).to have_css('h2', text: '2 receita(s) encontrada(s)')

    expect(page).to have_content(carrot_cake.title)
    expect(page).to have_css('li', text: carrot_cake.recipe_type.name)
    expect(page).to have_css('li', text: carrot_cake.cuisine.name)
    expect(page).to have_css('li', text: carrot_cake.difficulty)
    expect(page).to have_css('li', text: "#{carrot_cake.cook_time} minutos") 

    expect(page).to have_content(orange_cake.title)
    expect(page).to have_css('li', text: orange_cake.recipe_type.name)
    expect(page).to have_css('li', text: orange_cake.cuisine.name)
    expect(page).to have_css('li', text: orange_cake.difficulty)
    expect(page).to have_css('li', text: "#{orange_cake.cook_time} minutos") 
  end  
end