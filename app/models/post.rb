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
            User.find(user_id).projects.each do |project|
                if project.posts.include?(self)
                    return true
                end
            end
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
            if project.posts.include?(self)
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

    def owner_name
        User.find(self.user_id).username
    end

    def check_alert
        if self.alert_date != nil && !self.alerted
            if self.alert_date <= Time.now
                self.urgency_level = 5
                self.alerted = true
                self.save
            end
        end
    end

    def snippet
        if self.content.length > 20
            return "#{content.slice(0..17)}..."
        elsif self.content.length == 0
            return "No content..."
        else
            return content
        end
    end

    def display_alert_date(prefix = '')
        if self.alert_date == nil
            return ''
        else
            return "#{prefix} #{self.alert_date.to_s}"
        end
    end
end
