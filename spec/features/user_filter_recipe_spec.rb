require 'rails_helper'

feature 'User filter recipe' do
  scenario 'succesfully' do
    recipe = create(:recipe)

    visit root_path
    click_on recipe.recipe_type.name

    expect(page).to have_css('h1', text: recipe.recipe_type.name)
    expect(page).to have_css('h3', text: '1 receita(s) nesta categoria')
    expect(page).to have_content(recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and finds nothing' do
    recipe_type = create(:recipe_type)

    visit root_path
    click_on recipe_type.name

    expect(page).to have_css('h1', text: recipe_type.name)
    expect(page).to have_css('h3', text: 'Nenhuma receita nesta categoria.')
  end

  scenario 'and finds only one recipe' do
    main_dish = create(:recipe_type, name: 'Prato principal')
    dessert = create(:recipe_type, name: 'Sobremesa')
    create(:recipe, title: 'Macarronada', recipe_type: main_dish)
    cake = create(:recipe, title: 'Bolo', recipe_type: dessert)

    visit root_path
    click_on cake.recipe_type.name

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
