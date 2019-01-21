require 'rails_helper'

feature 'User uploads a profile photo' do
  scenario 'successfully' do
    user = login_user
    click_on 'Editar perfil'
    attach_file 'Foto', Rails.root.join('spec', 'support', 'images',
                                        'profile.jpg')
    click_on 'Salvar alterações'

    expect(page).to have_css('h2', text: user.email)
    expect(page).to have_css("img[src*='profile.jpg']")
  end

  scenario 'and can\'t upload it for other user profiles' do
    user = login_user
    other_user = create(:user)

    visit edit_user_path(other_user)

    expect(current_path).to eq edit_user_path(user)
  end
end
