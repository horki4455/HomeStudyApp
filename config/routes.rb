Rails.application.routes.draw do
  root 'static_pages#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post 'guest', to: 'user_sessions#guest'
  resources :users, only: %i[new create show]
  resource :profile, only: %i[show edit update]
  resources :tasks
  resources :boards do
    resources :comments, only: %i[create], shallow: true
  end
  resources :comments, only: %i[index update edit destroy], shallow: true
  resources :posts, shallow: true do
    resource :likes, only: %i[create destroy]
    get :likes, on: :collection
  end
  resources :relationships, only: [:create, :destroy]

  namespace :admin do
    root to: 'boards#index'
    resources :blogs
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :boards do#削除
      resources :comments, only: %i[create], shallow: true
    end
    resources :comments, only: %i[index update edit destroy], shallow: true
    resources :users, only: %i[index edit update show destroy]
  end
end
