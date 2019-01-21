require 'rails_helper'

feature 'Admin highlights recipe' do
  scenario 'succesfully' do
    admin = create(:admin)
    recipe = create(:recipe)

    login_as(admin, scope: :user)
    visit recipe_path(recipe)
    click_on 'Destacar'

    expect(current_path).to eq recipe_path(recipe)
    expect(page).to have_css("img[src*='star']")
    expect(page).to have_link 'Remover destaque'
    expect(page).not_to have_link 'Destacar'
  end

  scenario 'and view hilights on homepage' do
    admin = create(:admin)
    recipe = create(:recipe)

    login_as(admin, scope: :user)
    visit recipe_path(recipe)
    click_on 'Destacar'
    click_on 'Voltar'

    within('section#last-recipes') do
      expect(page).to have_css("img[src*='star']")
    end
  end

  scenario 'and must be admin' do
    login_user
    recipe = create(:recipe)

    visit recipe_path(recipe)

    expect(page).not_to have_link 'Destacar'
  end
end
