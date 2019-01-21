require 'rails_helper'

feature 'User view other user profile' do
  scenario 'succesfully' do
    login_user
    other_user = create(:user)
    recipe = create(:recipe, user: other_user)
    other_recipe = create(:recipe, user: other_user)

    visit recipe_path(recipe)
    click_on other_user.name

    expect(page).to have_css('h2', text: other_user.name)
    expect(page).to have_css("img[src*='profile_placeholder']")
    expect(page).to have_css('h4', text: 'Informações pessoais')
    expect(page).to have_css('h5', text: "Email: #{other_user.email}")
    expect(page).to have_css('h5', text: "Cidade: #{other_user.city}")
    expect(page).to have_css('h5', text: "Facebook: #{other_user.facebook}")
    expect(page).to have_css('h5', text: "Twitter: #{other_user.twitter}")
    expect(page).to have_css('h4', text: 'Receitas do usuário')
    expect(page).to have_link recipe.title
    expect(page).to have_link other_recipe.title
  end

  scenario 'and the other user has no recipes' do
    login_user
    other_user = create(:user)

    visit user_path(other_user)

    expect(page).to have_css('h2', text: other_user.name)
    expect(page).to have_css("img[src*='profile_placeholder']")
    expect(page).to have_css('h4', text: 'Receitas do usuário')
    expect(page).to have_css('h5', text: 'O usuário ainda não cadastrou '\
                                         'nenhuma receita.')
  end
end
