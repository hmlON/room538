Rails.application.routes.draw do
  root 'pages#index'
  resources :rooms, only: [:index, :new, :create]
  get '/rooms/edit' => 'rooms#edit', as: 'edit_room'
  put '/rooms' => 'rooms#update'
  delete '/rooms' => 'rooms#destroy'
  devise_for :users
end
