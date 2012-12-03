Blog::Application.routes.draw do

  get "sitemap/index"

  devise_for :users, {controllers: {omniauth_callbacks: "omniauth_callbacks"}}

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

  match "/sitemap" => "sitemap#index", as: :sitemap, defaults: {format: :xml}

end
