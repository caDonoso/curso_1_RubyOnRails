Rails.application.routes.draw do
  resources :mountains do
    resources :comments, only: [:create, :destroy, :update] #No tiene sentido que este solo, entonces se anida a mountains
  end
  devise_for :users
  root 'welcome#index'
end
