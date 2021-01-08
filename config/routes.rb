Rails.application.routes.draw do
  root to: 'homes#top'
  get 'main/about'
  get '/home/about', to: 'homes#about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :books, only: [:index, :new, :create, :edit, :update, :show, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
end
