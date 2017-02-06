Rails.application.routes.draw do
  get 'dashboard' => 'dashboard#index'
  root 'pages#index'
  resources :room_requests, only: [:index, :create, :destroy]
  resources :rooms, only: [:index, :new, :create]
  get '/rooms/edit' => 'rooms#edit', as: 'edit_room'
  patch '/rooms' => 'rooms#update'
  delete '/rooms' => 'rooms#destroy'
  devise_for :users
end
