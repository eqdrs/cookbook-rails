require 'rails_helper'

feature 'User creates recipes list' do
  scenario 'successfully' do
    user = login_user
    biscuit = create(:recipe, title: 'Biscuit')
    cake = create(:recipe, title: 'Cake')
    cheeseboard = create(:recipe, title: 'Cheeseboard')

    visit root_path
    click_on 'Criar lista'
    fill_in 'Nome', with: 'Ceia de natal'
    check biscuit.title
    check cake.title
    within('section#submit') do
      click_on 'Criar lista'
    end

    expect(page).to have_css('h2', text: 'Lista de receitas "Ceia de natal"')
    expect(page).to have_css('h5', text: "Criada por: #{user.email}")
    expect(page).to have_link(biscuit.title)
    expect(page).to have_link(cake.title)
    expect(page).not_to have_content(cheeseboard.title)
  end

  scenario 'and must select one recipe, at least' do
    login_user
    create(:recipe)

    visit new_recipes_list_path
    fill_in 'Nome', with: 'Ceia de natal'
    within('section#submit') do
      click_on 'Criar lista'
    end

    expect(page).to have_content('Você deve selecionar ao menos uma receita')
  end

  scenario 'and must fill in name' do
    login_user
    cake = create(:recipe, title: 'Cake')

    visit new_recipes_list_path
    fill_in 'Nome', with: ''
    check cake.title
    within('section#submit') do
      click_on 'Criar lista'
    end

    expect(page).to have_content('Você deve informar o nome da lista')
  end

  scenario 'and add new recipes to the list' do
    login_user
    biscuit = create(:recipe, title: 'Biscuit')
    cheeseboard = create(:recipe, title: 'Cheeseboard')

    visit root_path
    click_on 'Criar lista'
    fill_in 'Nome', with: 'Ceia de natal'
    check biscuit.title
    within('section#submit') do
      click_on 'Criar lista'
    end
    visit recipe_path(cheeseboard)
    select 'Ceia de natal', from: 'Adicionar à lista'
    click_on 'Adicionar'

    expect(current_path).to eq recipe_path(cheeseboard)
    expect(page).to have_content('Receita adicionada à lista Ceia de natal!')
  end

  scenario 'and can view added recipes on list' do
    user = login_user
    biscuit = create(:recipe, title: 'Biscuit')
    cake = create(:recipe, title: 'Cake')
    cheeseboard = create(:recipe, title: 'Cheeseboard')
    recipes_list = RecipesList.create!(name: 'Ceia de natal',
                                       recipe_ids: [biscuit.id], user: user)
    RecipesList.create!(name: 'Festa de aniversário',
                        recipe_ids: [cheeseboard.id],
                        user: user)

    visit recipe_path(cake)
    select 'Ceia de natal', from: 'Adicionar à lista'
    click_on 'Adicionar'
    visit recipes_list_path(recipes_list)

    expect(page).to have_link biscuit.title
    expect(page).to have_link cake.title
    expect(page).not_to have_link cheeseboard.title
  end
end
