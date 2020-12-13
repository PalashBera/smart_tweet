Rails.application.routes.draw do
  devise_for :users

  resources :tweets do
    resources :comments, only: %i[create destroy]
    resources :retweets, only: %i[new create]
  end

  root "home#index"
end
