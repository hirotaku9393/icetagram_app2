Rails.application.routes.draw do
  get "favorites/create"
  get "favorites/destroy"
  get "images/ogp"
  
  root "top#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"


  devise_for :users, class_name: "User", controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations"
  }

  namespace :admin do
    root "dashboard#index"
    resources :dashboard, only: [ :index ]
    resources :ice_creams
  end
  resources :ices, only: [ :index, :show, :new, :create ]

  resources :ajigraf, only: [ :index, :new, :create ] do
    collection do
      get "result", to: "ajigraf#result"
    end
  end

  #ネストされたルーティング(reviewsはice_creamsの子リソース)
  resources :ice_creams,  only: [ :index, :show, :new, :create, :edit, :update, :destroy ] do
    resources :reviews, only: [ :create, :destroy ]
    collection do
      get :favorites
      get :tags
      get :gotouchi
      get :calorie
    end
  end

  resources :favorites, only: [ :create, :destroy, :index ]

  resources :todayice, only: [ :index ] do
    collection do
      get "result"
    end
  end

  resources :images, only: [] do
    collection do
      get :ajigraf
      get :todayice
    end
  end

  resources :quizzes, only: [ :index ] do
    collection do
      post :check
      get :result
      get :explanation
    end
  end

  get "rakuten_search" => "ice_creams#search"


  devise_for :admins,
    controllers: { sessions: "admin/sessions" },
    path: "admin",
    skip: [ :registrations, :passwords ]

  post "/callback" => "linebot#callback"

  namespace :api do
    resources :ice_creams, only: [ :index ]
  end


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
