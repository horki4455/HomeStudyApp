Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :words, only: %i[index]
  resources :users, only: %i[new create]
  resource :profile, only: %i[show edit update]
  resources :posts

  namespace :admin do
    root to: 'boards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :boards do
      resources :comments, only: %i[create], shallow: true
    end
    resources :comments, only: %i[index], shallow: true
    resources :users, only: %i[index edit update show destroy]
  end
end
