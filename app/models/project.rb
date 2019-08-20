class Project < ApplicationRecord
    has_many :project_users
    has_many :users, through: :project_users
    has_many :post_projects
    has_many :posts, through: :post_projects

    def sort_my_posts_by_urgency
        alpha_sort = self.posts.sort do |a, b|
            a.title <=> b.title
        end
        alpha_sort.sort do |a, b|
            b.urgency_level <=> a.urgency_level
        end
    end

    def add_user(user)
        if !self.users.include?(user)
            self.users << user
        end
    end
    
    def vistor_can_view?(user=nil)
        if user == nil
            return self.public
        end
        user_has_permissions(user)
    end

    def user_has_permissions?(user)
        self.users.inclue?(user)
    end
end
