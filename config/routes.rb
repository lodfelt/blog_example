Blog::Application.routes.draw do

  devise_for :users

  root to: "articles#index"

  resources :users, only: [:show, :update]

  resources :articles, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
  end
  resources :tags, only: [:show]

  namespace :admin do
    resources :articles do
      resources :article_images, only: [:create, :update, :destroy]
    end
    resources :tags, only: [:index, :destroy]
    root to: "articles#index"
  end

end
