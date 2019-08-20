class StatsController < ApplicationController
    def index
        @num_posts = Post.num_posts
        @num_projects = Project.num_projects
        @num_users = User.num_users
        @num_public_projects = Project.num_public
        @average_num_posts = Project.average_num_posts
        @average_num_users = Project.average_num_users
        @percent_public = Project.percent_public
        @average_word_count = Post.average_word_count
        @most_viewed_public_project = Project.most_viewed_public_project
        @top_5_public_projects = Project.top_5_public_projects
    end
end