require 'rails_helper'

feature 'Admin register cuisine' do
  scenario 'successfully' do
    admin = create(:admin)

    login_as(admin, scope: :user)
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Arabe'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Arabe')
  end

  scenario 'and must fill in name' do
    admin = create(:admin)

    login_as(admin, scope: :user)
    visit new_cuisine_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome da cozinha')
  end

  scenario 'and must be unique' do
    admin = create(:admin)
    Cuisine.create(name: 'Brasileira')

    login_as(admin, scope: :user)
    visit new_cuisine_path
    fill_in 'Nome', with: 'BRASILEIRA'
    click_on 'Enviar'

    expect(page).to have_content('Esta cozinha já existe!')
  end
end
