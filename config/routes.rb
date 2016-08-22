Rails.application.routes.draw do
  root to: "homes#show"

  get "/auth/github", as: :github_login
  get "/auth/github/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  get "/auth/quizlet", as: :quizlet_login
  get "/auth/quizlet/callback", to: "users#add_quizlet"

  get "/account", to: "accounts#show", as: :account
  get "/community", to: "community#index", as: :community

  get "/api/v1/authenticate", to: "api/v1/users#show"
  get "/api/v1/sessions/statistics", to: "api/v1/sessions/statistics#index"
  post "/api/v1/skills", to: "api/v1/skills#create"
  post "/api/v1/goals", to: "api/v1/goals#create"
  post "/api/v1/sessions", to: "api/v1/sessions#create"
  post "/api/v1/sessions/cli", to: "api/v1/sessions/cli#create"
  patch "/api/v1/sessions/cli", to: "api/v1/sessions/cli#update"
  get "/quizlet/search", to: "search#index", as: :quizlet_search

  get 'api/v1/users/find' => 'api/v1/users/find#show', as: :user_search

  resources :users, only: [:edit, :update]
  get 'users/:nickname', to: 'users#show'
  resources :dashboard, only: [:index]
  resources :skills, only: [:index]
  resources :quizlet, only: [:index]
  resources :activity, only: [:index]
  resources :statistics, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :user_followers, only: [:create, :destroy]
    end
  end


end
