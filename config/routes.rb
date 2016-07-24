Rails.application.routes.draw do
  root to: "homes#show"

  get "/auth/quizlet", as: :quizlet_login
  get "/auth/quizlet/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  get "/api/v1/authenticate", to: "api/v1/users#show"

  resources :users, only: [:edit, :update]
  namespace :api do
    namespace :v1 do
      # resources :users, only: [:show]
    end
  end


end
