require 'rails_helper'

feature 'User sign up' do
  scenario 'succesfully' do
    visit root_path
    click_on 'Criar conta'
    fill_in 'Email', with: 'teste@gmail.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Cadastrar'

    expect(current_path).to eq root_path
    expect(page).not_to have_link('Criar conta')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_content('Olá, teste@gmail.com')
    expect(page).to have_link('Sair')
  end

  scenario 'and can login' do
    user = User.create!(email: 'teste@gmail.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    within("form#new_user") do
      click_on 'Entrar'
    end

    expect(current_path).to eq root_path
    expect(page).not_to have_link('Criar conta')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_content('Olá, teste@gmail.com')
    expect(page).to have_link('Sair')
  end

  scenario 'and can logout' do
    user = User.create!(email: 'teste@gmail.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    within("form#new_user") do
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(current_path).to eq root_path
    expect(page).to have_link('Criar conta')
    expect(page).to have_link('Entrar')
    expect(page).not_to have_content('Olá, teste@gmail.com')
    expect(page).not_to have_link('Sair')
  end
end