require 'rails_helper'

feature 'Admin register recipe_type' do
  scenario 'successfully' do
    admin = create(:admin)

    login_as(admin, scope: :user)
    visit root_path
    click_on 'Cadastrar tipo de receita'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Sobremesa')
  end

  scenario 'and must fill in name' do
    admin = create(:admin)

    login_as(admin, scope: :user)
    visit new_recipe_type_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome do tipo de receita')
  end

  scenario 'and must be unique' do
    admin = create(:admin)
    RecipeType.create(name: 'Sobremesa')

    login_as(admin, scope: :user)
    visit new_recipe_type_path
    fill_in 'Nome', with: 'SOBREMESA'
    click_on 'Enviar'

    expect(page).to have_content('Este tipo de receita já existe!')
  end
end
