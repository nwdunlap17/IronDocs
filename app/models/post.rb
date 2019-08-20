class Post < ApplicationRecord
    belongs_to :user
    has_many :post_projects
    has_many :projects, through: :post_projects

    def check_if_user_has_permission

    end
end
