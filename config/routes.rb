Rails.application.routes.draw do
  devise_for :users
  resources :groups, only: %i(index show) do
    resources :messages, only: %i(create)
  end
end
