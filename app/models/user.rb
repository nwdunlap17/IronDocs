class User < ApplicationRecord
    has_many :project_users
    has_many :projects, through: :project_users
    validates :username, uniqueness: true

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
end
