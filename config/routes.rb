Rails.application.routes.draw do
  root to: "homes#show"

  get "/auth/quizlet", as: :quizlet_login
  get "/auth/quizlet/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

end
