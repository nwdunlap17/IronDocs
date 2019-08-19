class PostProject < ApplicationRecord
    belongs_to :post
    belongs_to :project
    validate :post_on_project?

    def post_on_project?
        if self.post.projects.any? {|project| project.id == session[:project_id]} 
            errors.add(:post, "Post is already attached to this project")
        end
    end
end
