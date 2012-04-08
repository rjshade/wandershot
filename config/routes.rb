Wandershot::Application.routes.draw do
  resources :stories do
    resources :posts # /stories/abc/posts/xyz

    member do
      get 'map' # /stories/abc/map
    end

    collection do
      get 'popular'  # /stories/popular
    end
  end

  resources :comments

  devise_for :users, :path_names => { :sign_in => 'login',
                                      :sign_out => 'logout',
                                      :sign_up => 'signup' },
                     :controllers => { :sessions => 'sessions',
                                       :registrations => 'registrations' }
  resources :users, :only => [:index,:show]

  root :to => 'home#index'

  resources :admin, :only => :index do
    collection do
      get 'users'
      get 'posts'
      get 'stories'
      get 'comments'
    end
  end

  match 'about'   => 'pages#about'
  match 'contact' => 'pages#contact'
  match 'maps'    => 'pages#maps'
  match 'posts'   => 'posts#index'
end
