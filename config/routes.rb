Rails.application.routes.draw do
  devise_for :users

  get "/health", to: proc { [200, {}, ["OK"]] }

  root "movies#index"

  resources :movies do
    resources :reviews
  end
end
