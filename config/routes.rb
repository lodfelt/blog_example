Blog::Application.routes.draw do

  get "sitemap/index"

  devise_for :users, {controllers: {omniauth_callbacks: "omniauth_callbacks"}}

  root to: "articles#index"

  resources :users, only: [:show, :index, :update]

  resources :articles, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
  end
  resources :tags, only: [:show]

  namespace :admin do
    resources :articles do
      resources :article_images, only: [:create, :update, :destroy]
      get :drafts, on: :collection
    end
    resources :users, only: [:show, :create, :update, :destroy]
    resources :tags, only: [:index, :destroy]
    root to: "articles#index"
  end

  match "/sitemap" => "sitemap#index", as: :sitemap, defaults: {format: :xml}

end
