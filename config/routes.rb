Rails.application.routes.draw do
  devise_for :users
  resources :friends, only: %i(index)
  resources :groups, only: %i(index show) do
    resources :messages, only: %i(create)
  end
end
