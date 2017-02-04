Rails.application.routes.draw do
  get 'dashboard' => 'dashboard#index'
  root 'pages#index'
  resources :rooms, only: [:index, :new, :create]
  get '/rooms/edit' => 'rooms#edit', as: 'edit_room'
  patch '/rooms' => 'rooms#update'
  delete '/rooms' => 'rooms#destroy'
  devise_for :users
end
