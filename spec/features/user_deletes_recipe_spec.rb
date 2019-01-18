require 'rails_helper'

feature 'User deletes recipe' do
  scenario 'successfully' do
    user = login_user
    recipe = create(:recipe, user: user)

    visit recipe_path(recipe)
    click_on 'Apagar'

    expect(current_path).to eq root_path
    expect(page).to have_content('Receita apagada com sucesso!')
    expect(page).not_to have_content(recipe.title)
  end

  scenario 'and must be logged in' do
    recipe = create(:recipe)

    visit recipe_path(recipe)

    expect(page).not_to have_link('Apagar')
  end

  scenario 'and must be the author' do
    author = create(:user, email: 'autor@gmail.com')
    user = create(:user, email: 'usuario@hotmail.com')
    recipe = create(:recipe, user: author)

    login_as(user, scope: :user)
    visit recipe_path(recipe)

    expect(page).not_to have_link('Apagar')
  end
end
