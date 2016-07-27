Rails.application.routes.draw do
  root to: "homes#show"

  get "/auth/github", as: :github_login
  get "/auth/github/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  get "/auth/quizlet", as: :quizlet_login
  get "/auth/quizlet/callback", to: "users#add_quizlet"

  get "/account", to: "users#show", as: :account

  get "/api/v1/authenticate", to: "api/v1/users#show"

  resources :users, only: [:edit, :update]
  resources :dashboard, only: [:index]

  namespace :api do
    namespace :v1 do
      # resources :users, only: [:show]
    end
  end


end
