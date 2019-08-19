Rails.application.routes.draw do
  # resources :project_users
  get '/users/:id/new_project', to: "projects#new", as: "new_project"
  resources :projects, except: :new
  resources :users
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
