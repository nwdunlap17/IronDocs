class Project < ApplicationRecord
    has_many :project_users
    has_many :users, through: :project_users
    has_many :post_projects
    has_many :posts, through: :post_projects
    validates :title, presence: true

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
            return true
        end
        return false
    end


    def self.num_projects
        self.all.length
    end

    def self.public_projects
        self.all.select do |project|
            !!project.public
        end
    end

    def self.num_public
        self.public_projects.length
    end

    def self.average_num_posts
        (self.all.collect do |project|
            project.posts.length
        end.sum / (self.num_projects * 1.0)).round(2)
    end

    def self.average_num_users
        (self.all.collect do |project|
            project.users.length
        end.sum / (self.num_projects * 1.0)).round(2)
    end

    def self.percent_public
        ((100.0 * self.num_public) / self.num_projects).round(0)
    end

    def self.search_by_title(search)
        search = search.downcase
        projects = Project.all.select do |project|
            project.public && project.title.downcase.include?(search)
        end
        return projects.sort do |a,b|
            a.title <=> b.title
        end
    end
    
    def self.sort_by_views
        self.public_projects.sort_by do |project|
            project.views
        end
    end

    def self.top_5_public_projects
        self.sort_by_views.reverse.take(5)
    end

    def self.most_viewed_public_project
        self.sort_by_views.last
    end

    def update_post_alert_dates
        self.posts.each do |post|
            post.check_alert
        end
    end

    def owner_name
        User.find(self.user_id).name
    end
end
