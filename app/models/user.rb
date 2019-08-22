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

    def self.search_public_by_username(search)
        users = User.search_by_username(search)
        users.select do |user|
            judgement = false
            user.projects.each do |project|
                if project.public
                    judgement = true
                end
            end
            judgement
        end
    end


    def search_my_posts_by_name_and_priority(search)


        projectlist = self.projects
        # byebug
        postlist = []
        projectlist.each do |project|
            project.posts.each do |post|
                postlist << post
            end
        end

        postlist = postlist.uniq

        postlist = postlist.sort do |a,b|
            a.title <=> b.title
        end
        postlist = postlist.sort do |a,b|
            b.urgency_level <=> a.urgency_level
        end

        if search == nil || search == ''
            search = ''
            postlist = postlist.select do |post|
                post.urgency_level >= 4
            end
        else
            search = search.downcase
            postlistattempt = postlist.select do |post|
                post.title.downcase.include?(search)
            end
            if postlistattempt.count > 0
                postlist = postlistattempt
            else
                postlist = postlist.select do |post|
                    post.content.downcase.include?(search)
                end
            end
        end

        return postlist
    end

    def search_my_projects_by_name(search)
        projectlist = self.projects

        projectlist = projectlist.sort do |a,b|
            a.title <=> b.title
        end

        if search != nil && search != ''
            search = search.downcase

            projectlist = projectlist.select do |project|
                project.title.downcase.include?(search)
            end
        end

        return projectlist
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

    def self.get_name(id)
        return User.find(id).username
    end
    
    def self.num_users
        self.all.length
    end

    def search_users_by_username_giving_priority_to_friends(search)
        if search == nil
            search = ''
        end
        search = search.downcase
        friends = {}

        userslist = User.all.select do |user|
            friends[user.id] = 0
            user.username.downcase.include?(search) && (user != self)
        end

        userslist = userslist.sort do |a,b|
            a.username <=> b.username
        end

        self.projects.each do |project|
            project.users.each do |user|
                friends[user.id] += 1
            end
        end

        userslist = userslist.sort do |a,b|
            friends[b.id] <=> friends[a.id]
        end

        if search == ''
            userslist = userslist.select do |user|
                friends[user.id] > 0
            end
        end

        return userslist
    end

    def update_post_alert_dates
        self.projects.each do |project|
            project.update_post_alert_dates
        end
    end
end
