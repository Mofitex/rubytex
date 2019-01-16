Rails.application.routes.draw do
  root 'users#index'
  get 'login' => 'sessions#new'
  get 'register' => 'users#new'
  resources :sessions, only: :new
  post 'session/create' => 'sessions#create', as: :session_create
  delete 'session/destroy' => 'sessions#destroy', as: :session_destroy
  resources :comments
  resources :restaurants
  resources :users, except: :show do
    #get 'update' => 'users#update'
    #get 'destroy' => 'users#destroy'
    get 'delete' => 'users#delete'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
