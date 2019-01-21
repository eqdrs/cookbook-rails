require 'rails_helper'

feature 'User sign up' do
  scenario 'succesfully' do
    visit root_path
    click_on 'Criar conta'
    fill_in 'Nome', with: 'Fulano de Souza'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Email', with: 'teste@gmail.com'
    fill_in 'Twitter', with: ''
    fill_in 'Facebook', with: 'www.facebook.com/fulano'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Inscrever-se'

    expect(current_path).to eq root_path
    expect(page).not_to have_link('Criar conta')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_content('Olá, teste@gmail.com')
    expect(page).to have_link('Sair')
  end

  scenario 'and can login' do
    user = create(:user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '12345678'
    within('form#new_user') do
      click_on 'Entrar'
    end

    expect(current_path).to eq root_path
    expect(page).not_to have_link('Criar conta')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_content("Olá, #{user.email}")
    expect(page).to have_link('Sair')
  end

  scenario 'and can logout' do
    login_user

    visit root_path
    click_on 'Sair'

    expect(current_path).to eq root_path
    expect(page).to have_link('Criar conta')
    expect(page).to have_link('Entrar')
    expect(page).not_to have_content('Olá, teste@gmail.com')
    expect(page).not_to have_link('Sair')
  end
end
