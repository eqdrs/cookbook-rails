require 'rails_helper'

feature 'User register recipe' do
  scenario 'successfully' do
    user = login_user
    create(:recipe_type, name: 'Sobremesa')
    create(:recipe_type, name: 'Entrada')
    create(:cuisine, name: 'Arabe')

    visit root_path
    click_on 'Enviar receita'

    fill_in 'Título', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, '\
                                  'azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione '\
                                   'limão a gosto.'
    attach_file 'Foto', Rails.root.join('spec', 'support', 'images',
                                        'tabule.jpg')
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate '\
                                        'picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: 'Misturar tudo e servir. Adicione '\
                                        'limão a gosto.')
    expect(page).to have_css('h3', text: 'Autor')
    expect(page).to have_css('p', text: user.email)
    expect(page).to have_css("img[src*='tabule.jpg']")
  end

  scenario 'and doensn\'t upload a photo' do
    user = login_user
    create(:recipe_type, name: 'Entrada')
    create(:cuisine, name: 'Arabe')

    visit new_recipe_path

    fill_in 'Título', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, '\
                                  'azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione '\
                                   'limão a gosto.'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate '\
                                        'picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: 'Misturar tudo e servir. Adicione '\
                                        'limão a gosto.')
    expect(page).to have_css('h3', text: 'Autor')
    expect(page).to have_css('p', text: user.email)
    expect(page).to have_css("img[src*='noimage']")
  end

  scenario 'and must fill in all fields' do
    login_user
    visit new_recipe_path

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and must be logged in' do
    visit root_path

    expect(page).not_to have_link 'Enviar uma receita'
  end

  scenario 'and cant access recipe registration form' do
    visit new_recipe_path

    expect(current_path).to eq new_user_session_path
  end
end
