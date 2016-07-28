Rails.application.routes.draw do
  root to: "homes#show"

  get "/auth/github", as: :github_login
  get "/auth/github/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  get "/auth/quizlet", as: :quizlet_login
  get "/auth/quizlet/callback", to: "users#add_quizlet"

  get "/account", to: "users#show", as: :account

  get "/api/v1/authenticate", to: "api/v1/users#show"
  post "/api/v1/skills", to: "api/v1/skills#create"
  post "/api/v1/goals", to: "api/v1/goals#create"
  post "/api/v1/sessions", to: "api/v1/sessions#create"


  resources :users, only: [:edit, :update]
  resources :dashboard, only: [:index]
  resources :skills, only: [:index]
  resources :quizlet, only: [:index]
  resources :activity, only: [:index]

  namespace :api do
    namespace :v1 do
    end
  end


end
