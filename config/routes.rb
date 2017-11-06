Rails.application.routes.draw do
  root 'groups#index'
  devise_for :users
  resources :users, only: %i(index)
  resources :friends, only: %i(index create) do
    collection do
      get :search
    end
  end
  resources :groups, only: %i(index show create) do
    resources :messages, only: %i(create)
  end
end
