class Project < ApplicationRecord
    has_many :project_users
    has_many :users, through: :project_users
    has_many :post_projects
    has_many :posts, through: :post_projects

    def sort_my_posts_by_urgency
        self.posts.sort do |a, b|
            b.urgency_level <=> a.urgency_level
            #come back to sort alphabetically 
        end
    end
end
