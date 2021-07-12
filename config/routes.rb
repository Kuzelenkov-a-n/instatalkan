Rails.application.routes.draw do
  root to: "rooms#index"

  resources :rooms, only: %i[create index show destroy], param: :token
  resources :users, only: %i[index destroy]

  mount ActionCable.server => "/cable"
end
