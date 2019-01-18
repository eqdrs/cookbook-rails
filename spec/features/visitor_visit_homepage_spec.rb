require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: 'Bem-vindo ao maior livro de receitas '\
                                        'online')
  end

  scenario 'and view recipe' do
    recipe = create(:recipe)

    visit root_path

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view recipes list' do
    recipe = create(:recipe)
    another_recipe = create(:recipe)

    visit root_path

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h1', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end

  scenario 'and doesn\'t have recipes' do
    visit root_path

    expect(page).to have_content('Ainda não temos nenhuma receita. '\
                                 'Que tal enviar uma?')
  end

  scenario 'and view six last recipes' do
    carrot_cake = create(:recipe, title: 'Bolo de cenoura')
    orange_cake = create(:recipe, title: 'Bolo de laranja')
    strawberry_cake = create(:recipe, title: 'Bolo de morango')
    blueberry_cake = create(:recipe, title: 'Bolo de mirtilo')
    chocolate_cake = create(:recipe, title: 'Bolo de chocolate')
    corn_cake = create(:recipe, title: 'Bolo de milho')
    banana_cake = create(:recipe, title: 'Bolo de banana')

    visit root_path

    within('section#last-recipes') do
      expect(page).not_to have_content(carrot_cake.title)
      expect(page).to have_css('h3', text: 'Últimas receitas')
      expect(page).to have_content(orange_cake.title)
      expect(page).to have_content(strawberry_cake.title)
      expect(page).to have_content(blueberry_cake.title)
      expect(page).to have_content(chocolate_cake.title)
      expect(page).to have_content(corn_cake.title)
      expect(page).to have_content(banana_cake.title)
    end
  end
end
