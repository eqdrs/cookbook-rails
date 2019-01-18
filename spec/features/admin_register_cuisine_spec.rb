require 'rails_helper'

feature 'Admin register cuisine' do
  scenario 'successfully' do
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Arabe'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Arabe')
  end

  scenario 'and must fill in name' do
    visit new_cuisine_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome da cozinha')
  end

  scenario 'and must be unique' do
    Cuisine.create(name: 'Brasileira')

    visit new_cuisine_path
    fill_in 'Nome', with: 'BRASILEIRA'
    click_on 'Enviar'

    expect(page).to have_content('Esta cozinha já existe!')
  end
end
