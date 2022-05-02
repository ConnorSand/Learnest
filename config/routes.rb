Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get "/about", to: "pages#about"

  resources :questions, only: %i[index new create show update] do
    resources :answers, only: %i[create update]
  end
  resources :universities, only: %i[new create show update]
end
