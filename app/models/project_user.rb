class ProjectUser < ApplicationRecord
    belongs_to :user 
    belongs_to :project
    validate :user_on_project?

    def user_on_project?
        if self.project.users.any? {|user| user.id == session[:user_id]} 
            errors.add(:user, "User is already attached to this project")
        end
    end
end
