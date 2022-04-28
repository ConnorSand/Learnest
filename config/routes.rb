Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get "/about", to: "pages#about"

  resources :questions, only: %i[index new create show edit update] do
    resources :answers, only: %i[new create edit update]
  end
  resources :universities, only: %i[index new create show edit update]
end
