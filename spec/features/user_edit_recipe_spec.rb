require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    user = login_user
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    create(:recipe_type, name: 'Entrada')
    cuisine = create(:cuisine, name: 'Brasileira')
    create(:cuisine, name: 'Arabe')
    create(:recipe, title: 'Bolodecenoura', recipe_type: recipe_type,
                    cuisine: cuisine, user: user)

    visit root_path
    within('section#all-recipes') do
      click_on 'Bolodecenoura'
    end
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e '\
                                  'chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text: 'Cenoura, farinha, ovo, oleo de soja '\
                                        'e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de '\
                                        'chocolate')
    expect(page).to have_css('h3', text: 'Autor')
    expect(page).to have_css('p', text: user.email)
  end

  scenario 'and must fill in all fields' do
    user = login_user
    recipe = create(:recipe, user: user)

    visit root_path
    within('section#all-recipes') do
      click_on recipe.title
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
    recipe = create(:recipe)

    visit root_path
    within('section#all-recipes') do
      click_on recipe.title
    end

    expect(page).not_to have_link('Editar')
  end

  scenario 'and can\'t enter the edit route' do
    author = create(:user, email: 'autor@gmail.com')
    user = create(:user, email: 'usuario@gmail.com')
    recipe = create(:recipe, user: author)

    login_as(user, scope: :user)
    visit edit_recipe_path(recipe)

    expect(current_path).to eq root_path
  end

  scenario 'and must be the author' do
    author = create(:user, email: 'autor@gmail.com')
    user = create(:user, email: 'usuario@gmail.com')
    recipe = create(:recipe, user: author)

    login_as(user, scope: :user)
    visit recipe_path(recipe)

    expect(page).not_to have_link('Editar')
  end
end
