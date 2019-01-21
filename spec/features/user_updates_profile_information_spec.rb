require 'rails_helper'

feature 'User updates profile information' do
  scenario 'and receives success message' do
    login_user
    visit root_path
    click_on 'Editar perfil'
    fill_in 'Cidade', with: 'Rio de janeiro'
    fill_in 'Facebook', with: 'facebook.com/user'
    fill_in 'Senha atual', with: '12345678'
    click_on 'Atualizar'

    expect(current_path).to eq root_path
    expect(page).to have_content('A sua conta foi atualizada com sucesso.')
  end

  scenario 'and view changes' do
    user = create(:user, city: 'Salvador')

    login_as(user, scope: :user)
    visit edit_user_registration_path
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Facebook', with: ''
    fill_in 'Senha atual', with: '12345678'
    click_on 'Atualizar'
    visit user_path(user)

    expect(page).to have_css('h2', text: user.name)
    expect(page).to have_css("img[src*='profile_placeholder']")
    expect(page).to have_css('h4', text: 'Informações pessoais')
    expect(page).to have_css('h5', text: "Email: #{user.email}")
    expect(page).to have_css('h5', text: 'Cidade: São Paulo')
    expect(page).to have_css('h5', text: "Twitter: #{user.twitter}")
    expect(page).not_to have_content(user.facebook)
  end

  scenario 'and must fill in required fields' do
    login_user
    visit edit_user_registration_path
    fill_in 'Nome', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Senha atual', with: '12345678'
    click_on 'Atualizar'

    expect(page).to have_content('O campo de nome é obrigatório')
    expect(page).to have_content('O campo de cidade é obrigatório')
  end
end