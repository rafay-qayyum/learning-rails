Rails.application.routes.draw do
  root "login#new"
  resources :articles do
    resources :comments
  end
  resources :login, only: [:new,:create]
  resources :user, only: [:new,:create]
  get 'logout', to: 'login#destroy'
end
