Wandershot::Application.routes.draw do
  resources :stories do
    resources :posts
  end

  resources :comments

  devise_for :users, :path_names => { :sign_in => 'login',
                                      :sign_out => 'logout',
                                      :sign_up => 'signup' },
                     :controllers => { :sessions => 'sessions',
                                       :registrations => 'registrations' }
  resources :users, :only => [:index,:show]

  root :to => 'home#index'

  match 'about'   => 'pages#about'
  match 'contact' => 'pages#contact'
  match 'maps'    => 'pages#maps'
end
