require 'rails_helper'

feature 'User uploads a profile photo' do
  scenario 'successfully' do
    user = login_user
    click_on 'Editar perfil'
    attach_file 'Foto', Rails.root.join('spec', 'support', 'images',
                                        'profile.jpg')
    click_on 'Atualizar'
    visit user_path(user)

    expect(page).to have_css('h2', text: user.name)
    expect(page).to have_css("img[src*='profile.jpg']")
  end
end
