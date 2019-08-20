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

    def self.num_projects
        self.all.length
    end

    def self.num_public
        self.all.select do |project|
            !!project.public
        end.length
    end

    def self.average_num_posts
        self.all.collect do |project|
            project.posts.length
        end.sum / (self.num_projects * 1.0)
    end

    def self.average_num_users
        (self.all.collect do |project|
            project.users.length
        end.sum / (self.num_projects * 1.0)).round(2)
    end

    def self.percent_public
        (1.0 * self.num_public) / self.num_projects
    end
end
