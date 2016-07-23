Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Add a get route for /auth/twitter (this is a special route used by omniauth) and specify :twitter_login as the value for the :as key. You don't need to specify the :to key.
  root to: "homes#show"

  get "/auth/quizlet", as: :quizlet_login
  get "/auth/quizlet/callback", to: "sessions#create"


end
