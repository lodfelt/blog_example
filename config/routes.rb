Blog::Application.routes.draw do

  get "tags/show"

  get "tags_controller/show"

  devise_for :users

  root to: "articles#index"

  resources :articles do
    resources :comments
  end
  resources :tags

end
