Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post 'guest', to: 'user_sessions#guest'
  resources :words, only: %i[index]
  resources :users, only: %i[new create]
  resource :profile, only: %i[show edit update]
  resources :posts
  resources :posts, shallow: true do
    resource :likes, only: %i[create destroy]
    get :likes, on: :collection
  end
  resources :calendars

  namespace :admin do
    root to: 'boards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :boards do
      resources :comments, only: %i[create], shallow: true
    end
    resources :comments, only: %i[index edit destroy], shallow: true
    resources :users, only: %i[index edit update show destroy]
  end
end
