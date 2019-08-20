Rails.application.routes.draw do
  # get '/users/:id/new_project', to: "projects#new", as: "new_project"
  post '/posts/new', to: "posts#new_for_project", as: "new_project_post"

  get '/projects/invite', to: "projects#search_invite_user"
  post '/projects/invite', to: "projects#search_invite_user", as: "user_invite"
  get '/projects/invite/user/:id', to: 'projects#add_user_to_project'

  get '/login', to: 'auth#login'
  post '/login', to: 'auth#verify'
  
  resources :projects
  resources :users
  resources :posts
  # resources :post_projects
  # resources :project_users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
