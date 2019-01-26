Rails.application.routes.draw do
  root 'restaurants#index'
  get 'login' => 'sessions#new'
  get 'register' => 'users#new'
  resources :sessions, only: :new
  post 'session/create' => 'sessions#create', as: :session_create
  delete 'session/destroy' => 'sessions#destroy', as: :session_destroy
  resources :comments do
    get '/review' => 'comments#restaurant_comments'
    collection do
      get '/owncomment' => 'comments#user_comments'
    end
  end

  resources :restaurants do
    collection do
      get '/owner' => 'restaurants#user_restaurants'
    end
  end
  resources :users do
    #get 'update' => 'users#update'
    #get 'destroy' => 'users#destroy'
    get 'delete' => 'users#delete'
    get 'profile' => 'users#profile'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
