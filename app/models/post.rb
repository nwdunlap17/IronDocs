class Post < ApplicationRecord
    belongs_to :user
    has_many :post_projects
    has_many :projects, through: :post_projects

    def visitor_has_view_rights?(user_id = nil)
        self.projects.each do |project|
            if project.public
                return true
            end
        end

        if user_id != nil
            return user_has_access_rights?(user_id)
        end

        return false
    end

    def user_has_access_rights?(user_id)
        if user_id == nil
            return false
        end
        if self.user_id == user_id 
            return true
        end

        User.find(user_id).projects.each do |project|
            if project.posts.include?(@post)
                return true
            end
        end

        return false
    end

    def self.num_posts
        self.all.length
    end

    def self.average_word_count
        (self.all.collect do |post|
            post.content.split(" ").length
        end.sum / (self.num_posts * 1.0)).round(2)
    end
end
