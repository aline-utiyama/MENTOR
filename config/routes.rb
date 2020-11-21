Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :mentors do
    resources :consultations, only: [:new, :index, :create ]
    resources :reviews, only: :create

  end

  namespace :mentor do
    get "consultations", to: "consultations#index", as: "consultation"
  end



  resources :consultations
end
