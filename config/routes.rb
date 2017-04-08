Rails.application.routes.draw do
  root 'pages#index'
  get 'about' => 'pages#about'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :rooms, only: [:index, :new, :create]
  scope 'rooms', controller: :rooms do
    get 'edit', as: 'edit_room'
    patch '/', action: :update
    get 'join', as: 'join_room'
    patch 'reset-progress', as: 'reset_room_progress'
    patch 'leave', as: 'leave_room'
  end

  scope 'dashboard', controller: :dashboard do
    get '/', action: :index, as: 'dashboard'
    post 'do', action: :do_action, as: 'do_action'
    post 'punish', as: 'punish'
  end

  resources :room_requests, only: [:index, :create, :destroy] do
    post 'accept', on: :member
  end

  resources :actions, only: [:create, :destroy]
end
