Wandershot::Application.routes.draw do
  resources :posts
  resources :stories

  devise_for :users
  resources :users, :only => [:index,:show]

  root :to => 'home#index'

  match 'about'   => 'pages#about'
  match 'contact' => 'pages#contact'
end
