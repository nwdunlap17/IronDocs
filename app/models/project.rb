class Project < ApplicationRecord
    has_many :project_users
    has_many :users, through: :project_users
    has_many :post_projects
    has_many :posts, through: :post_projects
end
