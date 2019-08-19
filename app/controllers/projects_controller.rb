class ProjectsController < ApplicationController
<<<<<<< HEAD
    before_action :grab_project, only: [:show, :edit, :updat]
=======
    before_action :grab_project, only: [:show, :edit, :update, :destroy]
>>>>>>> 2ab3b7638eca4568c2f91bd3c7a77619b7eafbe0
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

<<<<<<< HEAD

    def search_invite_user
        # byebug
        @project = Project.find(session[:project_id])
        @users = User.search_by_username(params[:search])
        render :invite
=======
    def destroy
        if @project.users.length > 1
            @project.users.delete_if { |user| user.id == session[:user_id]}
        else
            redirect_to "/users/#{session[:user_id]}"
        end
>>>>>>> 2ab3b7638eca4568c2f91bd3c7a77619b7eafbe0
    end

    private

    def grab_project
        @project = Project.find(params[:id])
    end

    def project_params
        params.require(:project).permit(:title, :description)
    end
end