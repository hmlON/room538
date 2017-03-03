Rails.application.routes.draw do
  get 'dashboard' => 'dashboard#index'
  post 'dashboard/do' => 'dashboard#do_action', as: 'do_action'
  root 'pages#index'
  patch 'room/leave' => 'rooms#leave', as: 'leave_room'
  patch 'room/reset-progress' => 'rooms#reset_progress', as: 'reset_room_progress'
  post 'room_requests/accept/:id' => 'room_requests#accept', as: 'accept_room_request'
  resources :room_requests, only: [:index, :create, :destroy]
  resources :rooms, only: [:index, :new, :create]
  resources :actions, only: [:new, :create, :destroy]
  get '/rooms/edit' => 'rooms#edit', as: 'edit_room'
  patch '/rooms' => 'rooms#update'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'about' => 'pages#about'
end
