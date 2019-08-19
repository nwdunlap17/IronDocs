Rails.application.routes.draw do
  # get '/users/:id/new_project', to: "projects#new", as: "new_project"
  post '/posts/new', to: "posts#new_for_project", as: "new_project_post"
  resources :projects
  resources :users
  resources :posts
  # resources :post_projects
  # resources :project_users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
