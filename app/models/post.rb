class Post < ApplicationRecord
    belongs_to :user
    has_many :post_projects
    has_many :projects, through: :post_projects

    def user_has_access_rights?(user)
        if self.user_id == user.id 
            return true
        end

        user.projects.each do |project|
            if project.posts.include?(@post)
                return true
            end
        end

        return false
    end
end
