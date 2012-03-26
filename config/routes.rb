Wandershot::Application.routes.draw do
  resources :posts

  resources :stories

  devise_for :users

  root :to => "home#index"

  resources :users, :only => [:index,:show]
end
