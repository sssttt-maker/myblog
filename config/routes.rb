Rails.application.routes.draw do
  resources :posts, only: %i[index show]
  resources :categories, only: %i[show]
  resources :contacts, only: %i[new create]
  # resources :galleries, only: %i[index] do
  #   collection do
  #     get '/image', to: 'galleries#get_url'
  #   end
  # end
  get '/top', to: 'tops#index'
  get '/about', to: 'about#index'
  get '/menu', to: 'menu#index'
  get '/privacy', to: 'privacy_policy#index'
  get '/sitemaps', to: 'sitemap#index'
  root to: 'tops#index'
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  namespace :admin do
    get '/', to: 'home#index'
    resources :posts, only: %i[new create edit update destroy] do
      get :all, :published, :drafts, on: :collection
      post :upload_image, on: :collection
    end
    resources :categories, only: %i[index create edit update show destroy]
    resources :galleries, only: %i[create new destroy]
  end
  devise_for :users

  get 'sitemap', to: redirect('https://s3-ap-northeast-1.amazonaws.com/myblog-production/sitemaps/sitemap.xml.gz')

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
