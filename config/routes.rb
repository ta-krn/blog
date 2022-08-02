Rails.application.routes.draw do
  root to: 'articles#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users do
    member do
      get :followings
      get :followers
      get :like_articles
    end
  end
  
  resources :articles
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  get 'search_tag', to: 'articles#search_tag'
  get 'search', to: 'articles#search'
end