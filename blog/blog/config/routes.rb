Rails.application.routes.draw do
  

  resources :comments
  devise_for :users
  resources :mountains
=begin
   get "/mountains"
   post "/mountains"
   delete "/mountains"
   get "/mountains/:id"
   get "/mountains/new"
   get "/mountains/:id/edit"
   patch "/mountains/:id"
   put "/mountains/:id"
=end
   


  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
