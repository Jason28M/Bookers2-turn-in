Rails.application.routes.draw do
  devise_for :users
  root 'home#home'
  get "books" => "books#books"
  get "home/about" => "home#about"
  resources :users, only: [:edit, :update, :show, :index]
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
