Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get "/about", to: "pages#about"
  get "/notifications", to: "pages#notifications"
  patch "/notifications/:id", to: "notifications#mark_as_read", as: :notification
  # get '/tagged', to: "questions#tagged", as: :tagged

  resources :questions, only: %i[index new create show update] do
    member do
      patch "upvote", to: "questions#upvote"
      patch "downvote", to: "questions#downvote"
    end
    resources :answers, only: %i[create update] do
      member do
        patch "upvote", to: "answers#upvote"
        patch "downvote", to: "answers#downvote"
      end
    end
  end


  resources :universities, only: %i[new create show update]
end
