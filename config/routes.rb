Rails.application.routes.draw do
  # get '/users/:id/new_project', to: "projects#new", as: "new_project"
  post '/posts/new', to: "posts#new_for_project", as: "new_project_post"
  post '/posts/copy/:id', to: "posts#copy", as: "copy_post"

  get '/projects/:id/invite', to: "projects#search_invite_user", as: "project_invite"
  post '/projects/:id/invite', to: "projects#search_invite_user", as: "project_invite_search"
  get '/projects/:id/invite/user/:user_id', to: 'projects#add_user_to_project'
  get '/stats/index', to: 'stats#index'

  get '/login', to: 'auth#login'
  post '/login', to: 'auth#verify'
  delete '/logout', to: 'auth#destroy'

  get '/', to: 'home#home'
  get '/home', to: 'home#home', as: 'home'
  post '/home/public_search', to: 'home#public_search', as: 'public_search'

  post '/users/:id/search', to:'users#show', as: 'search_own_files'

  resources :projects, except: [:index]
  resources :users, except: [:index, :edit, :update, :destroy]
  resources :posts, except: [:index]
  # resources :post_projects
  # resources :project_users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
