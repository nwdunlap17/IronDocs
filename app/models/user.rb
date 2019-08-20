class User < ApplicationRecord
    has_many :project_users
    has_many :projects, through: :project_users
    validates :username, uniqueness: true
    has_secure_password

    def self.list_alphabetically
        users = User.all.sort do |a,b|
            a.username.downcase <=> b.username.downcase
        end
    end

    def self.search_by_username(search)
        users = User.list_alphabetically
        if !!search
            search = search.downcase
            users = users.select do |user|
                user.username.downcase.include?(search)
            end
        end
        return users
    end

    def visible_projects(visitor_id)
        if visitor_id == self.id 
            return self.projects
        end

        visible_projects = []
        
        if visitor_id != nil
            visitor = User.find(visitor_id)

            self.projects.each do |project|
                if project.public || project.users.include?(visitor)
                    visible_projects << project
                end
            end
        else
            self.projects.each do |project|
                if project.public
                    visible_projects << project
                end
            end
        end
        return visible_projects
    end
end
