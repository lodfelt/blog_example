Blog::Application.routes.draw do

  devise_for :users

  root to: "articles#index"

  resources :articles, only: [:index, :show] do
    resources :comments, only: [:create]
  end
  resources :tags, only: [:show]

  namespace :admin do
    resources :articles do
      post 'published', on: :member
      resources :comments, only: [:destroy]
    end
    resources :tags, only: [:destroy]
    root to: "articles#index"
  end

end
