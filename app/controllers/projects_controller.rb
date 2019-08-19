class ProjectsController < ApplicationController
    before_action :grab_project, only: [:show, :edit, :update, :destroy]
    def index
        @projects = Project.all
    end

    def show
        @posts = @project.sort_my_posts_by_urgency
        session[:project_id] = @project.id
    end

    def new
        @project = Project.new
    end

    def create 
        @project = Project.new(project_params)

        @project.users << User.find(session[:user_id])
        if @project.save
            
            redirect_to project_path(@project)
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @project.update(project_params)
            redirect_to project_path(@project)
        else
            render :edit
        end
    end


    def search_invite_user
        @project = Project.find(session[:project_id])
        @users = User.search_by_username(params[:search])
        render :invite
    end

    def add_user_to_project
        @project = Project.find(session[:project_id])
        @user = User.find(params[:id])
        @project.add_user(@user)

        redirect_to '/projects/invite'
    end

    def destroy
        if @project.users.length > 1
            @project.users.delete_all { |user| user.id == session[:user_id]}
        else 
            @project.delete
        end
        redirect_to "/users/#{session[:user_id]}"
    end

    private

    def grab_project
        @project = Project.find(params[:id])
    end

    def project_params
        params.require(:project).permit(:title, :description)
    end
end