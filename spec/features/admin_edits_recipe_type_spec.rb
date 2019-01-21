require 'rails_helper'

feature 'Admin edits recipe type' do
  scenario 'succesfully' do
    recipe_type = create(:recipe_type, name: 'Srobermesa')
    admin = create(:admin)

    login_as(admin, scope: :user)
    visit root_path
    click_on 'Ver tipos de receita'
    click_on recipe_type.name
    click_on 'Editar'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Sobremesa')
    expect(page).not_to have_content('Srobermesa')
  end

  scenario 'and must fill in all fields' do
    recipe_type = create(:recipe_type)
    admin = create(:admin)

    login_as(admin, scope: :user)
    visit edit_recipe_type_path(recipe_type)
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome do tipo de receita')
  end

  scenario 'and the name must be unique' do
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    create(:recipe_type, name: 'Prato principal')
    admin = create(:admin)

    login_as(admin, scope: :user)
    visit edit_recipe_type_path(recipe_type)
    fill_in 'Nome', with: 'PRATO PRINCIPAL'
    click_on 'Enviar'

    expect(page).to have_content('Este tipo de receita já existe!')
  end

  scenario 'and must be admin' do
    recipe_type = create(:recipe_type)

    login_user
    visit edit_recipe_type_path(recipe_type)

    expect(current_path).to eq root_path
    expect(page).not_to have_link 'Ver tipos de receita'
  end
end
