class PostProject < ApplicationRecord
    belongs_to :post
    belongs_to :project
    validate :post_on_project?

    def post_on_project?
        if self.project.posts.include? (self.post)
            errors.add(:post, "Post is already attached to this project")
        end
    end
end
