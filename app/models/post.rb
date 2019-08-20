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

    def self.num_posts
        self.all.length
    end

    def self.average_word_count
        (self.all.collect do |post|
            post.content.split(" ").length
        end.sum / (self.num_posts * 1.0)).round(2)
    end
end
