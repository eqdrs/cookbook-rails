require 'rails_helper'

feature 'User filter recipe' do
  scenario 'succesfully' do
    user = User.create!(email: 'teste@gmail.com', password: '123456')
    dessert = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    cake = Recipe.create(title: 'Bolo de cenoura', recipe_type: dessert,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           user: user)

    visit root_path
    click_on 'Sobremesa'

    expect(page).to have_css('h1', text: 'Sobremesa')
    expect(page).to have_css('h3', text: '1 receita(s) nesta categoria')
    expect(page).to have_content(cake.title)
    expect(page).to have_css('li', text: cake.recipe_type.name)
    expect(page).to have_css('li', text: cake.cuisine.name)
    expect(page).to have_css('li', text: cake.difficulty)
    expect(page).to have_css('li', text: "#{cake.cook_time} minutos") 
  end

  scenario 'and finds nothing' do
    dessert = RecipeType.create(name: 'Sobremesa')

    visit root_path
    click_on 'Sobremesa'

    expect(page).to have_css('h1', text: 'Sobremesa')
    expect(page).to have_css('h3', text: 'Nenhuma receita nesta categoria.')
  end

  scenario 'and finds only one recipe' do
    user = User.create!(email: 'teste@gmail.com', password: '123456')
    dessert = RecipeType.create(name: 'Sobremesa')
    main_dish = RecipeType.create(name: 'Prato principal')
    cuisine = Cuisine.create(name: 'Brasileira')
    pasta = Recipe.create(title: 'Macarronada', recipe_type: main_dish,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Macarrão, água, sal e óleo',
                           cook_method: 'Coloque o macarrão na água, com óleo, sal e então ferva.',
                           user: user)
    cake = Recipe.create(title: 'Bolo de cenoura', recipe_type: dessert,
                           cuisine: cuisine, difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           user: user)

    visit root_path
    click_on 'Sobremesa'

    expect(page).not_to have_content('Macarronada')

    expect(page).to have_css('h1', text: 'Sobremesa')
    expect(page).to have_css('h3', text: '1 receita(s) nesta categoria')
    expect(page).to have_content(cake.title)
    expect(page).to have_css('li', text: cake.recipe_type.name)
    expect(page).to have_css('li', text: cake.cuisine.name)
    expect(page).to have_css('li', text: cake.difficulty)
    expect(page).to have_css('li', text: "#{cake.cook_time} minutos") 
  end
end