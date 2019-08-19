class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :delete]

    def index
        @posts = Post.all
    end

    def show
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = session[:user_id]
<<<<<<< HEAD
        @post.projects << Project.find(session[:project_id])
=======
>>>>>>> 9c77e5bd62c5e5a0ccf9fa9d3802e2644250159b
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
        redirect_to :index
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:content, :title, :user_id, :urgency_level, :public_access)
    end

   
end
