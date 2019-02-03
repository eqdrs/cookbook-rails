Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :recipes do
    patch 'highlight_recipe', to: 'recipes#highlight_recipe', as: 'highlight'
    patch 'add_to_list', to: 'recipes#add_to_list', as: 'add_to_list'
  end
  resources :recipe_types, only: %i[index show new create edit update]
  resources :cuisines, only: %i[index show new create edit update]
  get "/search", to: "recipes#search"
  resources :users, only: %i[show edit update] do
    get 'my_lists', to: 'users#my_lists', as: 'lists'
  end
  resources :recipes_lists, only: %i[show new create]
  namespace :api, defaults: { format: :JSON } do
    namespace :v1 do
      get 'recipes/:id', to: 'recipes#show'
      post 'recipes/new', to: 'recipes#create'
    end
  end

end
