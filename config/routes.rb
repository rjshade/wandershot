Wandershot::Application.routes.draw do
  resources :stories do
    resources :posts
  end

  devise_for :users
  resources :users, :only => [:index,:show]

  root :to => 'home#index'

  match 'about'   => 'pages#about'
  match 'contact' => 'pages#contact'
end
