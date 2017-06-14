Rails.application.routes.draw do
  root 'pages#index'
  get 'about' => 'pages#about'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :rooms, only: [:index]
  resource :room, only: [:new, :create, :edit, :update] do
    get 'join'
    patch 'reset-progress'
    patch 'leave'
  end

  scope 'dashboard', controller: :dashboard do
    get '/', action: :index, as: 'dashboard'
    post 'submit-done-action'
    post 'punish', as: 'punish' # TODO: switch to punishments#create
  end

  resources :room_requests, only: [:index, :create, :destroy] do
    post 'accept', on: :member
  end

  resources :actions, only: [:create, :destroy]

  resources :punishments, only: [:index]
end
