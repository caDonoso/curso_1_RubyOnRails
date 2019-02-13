Rails.application.routes.draw do
  resources :categories
  resources :mountains do
    resources :comments, only: [:create, :destroy, :update] #No tiene sentido que este solo, entonces se anida a mountains
  end
  devise_for :users
  root 'welcome#index'

  get '/dashboard', to: "welcome#dashboard"

  #Como la accion publicar modifica un elemento, entonces se utiliza put
  put "/mountains/:id/publish", to: "mountains#publish"
  put "/mountains/:id/unpublish", to: "mountains#unpublish"
end
