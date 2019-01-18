module Functions
  def login_user
    user = create(:user)

    visit new_user_session_path

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password

    within('form#new_user') do
      click_on 'Entrar'
    end
    user
  end
end
