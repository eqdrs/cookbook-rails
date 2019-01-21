require 'rails_helper'

feature 'Admin edits cuisine' do
  scenario 'succesfully' do
    cuisine = create(:cuisine, name: 'Protuguesaa')
    admin = create(:admin)

    login_as(admin, scope: :user)
    visit root_path
    click_on 'Ver cozinhas'
    click_on cuisine.name
    click_on 'Editar'
    fill_in 'Nome', with: 'Portuguesa'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Portuguesa')
    expect(page).not_to have_content('Protuguesaa')
  end

  scenario 'and must fill in all fields' do
    cuisine = create(:cuisine)
    admin = create(:admin)

    login_as(admin, scope: :user)
    visit edit_cuisine_path(cuisine)
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome da cozinha')
  end

  scenario 'and the name must be unique' do
    cuisine = create(:cuisine, name: 'Portuguesa')
    create(:cuisine, name: 'Brasileira')
    admin = create(:admin)

    login_as(admin, scope: :user)
    visit edit_cuisine_path(cuisine)
    fill_in 'Nome', with: 'BRASILEIRA'
    click_on 'Enviar'

    expect(page).to have_content('Esta cozinha já existe!')
  end

  scenario 'and must be admin' do
    cuisine = create(:cuisine)

    login_user
    visit edit_cuisine_path(cuisine)

    expect(current_path).to eq root_path
    expect(page).not_to have_link 'Ver cozinhas'
  end
end
