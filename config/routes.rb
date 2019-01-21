Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :recipes do
    patch 'highlight_recipe', to: 'recipes#highlight_recipe', as: 'highlight'
  end
  resources :recipe_types, only: %i[show new create]
  resources :cuisines, only: %i[index show new create edit update]
  get "/search", to: "recipes#search"
  resources :users, only: %i[show edit update] do
    get 'my_lists', to: 'users#my_lists', as: 'lists'
  end
  resources :recipes_lists, only: %i[show new create]
end
