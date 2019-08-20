Rails.application.routes.draw do
  # get '/users/:id/new_project', to: "projects#new", as: "new_project"
  post '/posts/new', to: "posts#new_for_project", as: "new_project_post"

  get '/projects/:id/invite', to: "projects#search_invite_user", as: "project_invite"
  post '/projects/:id/invite', to: "projects#search_invite_user", as: "project_invite_search"
  get '/projects/:id/invite/user/:user_id', to: 'projects#add_user_to_project'

  get '/login', to: 'auth#login'
  post '/login', to: 'auth#verify'
  delete '/logout', to: 'auth#destroy'

  resources :projects
  resources :users
  resources :posts
  # resources :post_projects
  # resources :project_users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
