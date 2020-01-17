Rails.application.routes.draw do
  resources :posts, only: %i[index show]
  resources :galleries, only: %i[index] do
    collection do
      get '/image', to: 'galleries#get_url'
    end
  end
  get '/top', to: 'tops#index'
  get '/about', to: 'about#index'
  get '/menu', to: 'menu#index'
  root to: 'tops#index'
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  namespace :admin do
    get '/', to: 'home#index'
    resources :posts, only: %i[new create edit update destroy] do
      get :all, :published, :drafts, on: :collection
    end
    resources :categories, only: %i[index create show destroy]
    resources :galleries, only: %i[create new destroy]
  end
  devise_for :users

end
