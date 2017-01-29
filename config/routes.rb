Rails.application.routes.draw do
  root 'pages#index'
  resources :rooms
  devise_for :users
end
