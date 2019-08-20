class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :check_for_user_permission, except: [:index, :new, :create]
    before_action :check_for_login
    def index
        @posts = Post.all
    end

    def show
        @last_project = Project.find(session[:project_id])
        renderer = Redcarpet::Render::HTML
        @markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    end

    def new
        @post = Post.new
        @post.title = "New Post"
        @post.public_access = true
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = session[:user_id]
        @post.projects << Project.find(session[:project_id])
        @post.save
        redirect_to post_path(@post)
    end

    def edit
    end

    def update
        @post.update(post_params)
        redirect_to @post
    end

    def destroy
        @post.delete
        redirect_to project_path(session[:project_id])
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:content, :title, :user_id, :urgency_level, :public_access)
    end

    def check_for_user_permission
        set_post
        user = User.find(session[:user_id])
        if !@post.user_has_access_rights?(user)
            redirect_to user_path(user)
        end
    end
end
