require 'rails_helper'

feature 'Visitor view recipe details' do
  scenario 'successfully' do
    user = login_user
    recipe = create(:recipe, user: user)

    visit root_path
    within('section#all-recipes') do
      click_on recipe.title
    end

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: recipe.recipe_type.name)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)
    expect(page).to have_css('p', text: "#{recipe.cook_time} minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: recipe.ingredients)
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: recipe.cook_method)
    expect(page).to have_css('h3', text: 'Autor')
    expect(page).to have_css('p', text: user.email)
  end

  scenario 'and return to recipe list' do
    recipe = create(:recipe)

    visit root_path
    within('section#all-recipes') do
      click_on recipe.title
    end
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end
end
