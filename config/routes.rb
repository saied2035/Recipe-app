Rails.application.routes.draw do
  resources :foods
  devise_for :users
  resources :users
  resources :recipes do
     resources :recipe_foods, only:[:new,:create,:destroy]
  end
  get "/public_recipes" , to: "recipes#public_recipes"
  get "/shopping_list" , to: "recipe_foods#shopping_list"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # devise_for :users 
  root "recipes#public_recipes"
end
