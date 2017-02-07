Rails.application.routes.draw do
  get 'dashboard' => 'dashboard#index'
  post 'dashboard/do' => 'dashboard#do_action', as: 'do_action'
  root 'pages#index'
  post 'room_requests/accept/:id' => 'room_requests#accept', as: 'accept_room_request'
  resources :room_requests, only: [:index, :create, :destroy]
  resources :rooms, only: [:index, :new, :create]
  get '/rooms/edit' => 'rooms#edit', as: 'edit_room'
  patch '/rooms' => 'rooms#update'
  delete '/rooms' => 'rooms#destroy'
  devise_for :users
end
