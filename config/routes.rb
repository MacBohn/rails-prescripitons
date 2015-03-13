Rails.application.routes.draw do
  root "dashboard#index"
  get "signin" => "sessions#new", as: :signin
  post "signin" => "sessions#create"
  delete "signout" => "sessions#destroy", as: :signout

  resources :patients do
    resources :prescriptions
  end
  resources :medications
end
