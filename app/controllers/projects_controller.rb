class ProjectsController < ApplicationController
    before_action :grab_project, except: [:new, :create]
    before_action :check_for_user_permission, except: [:new, :create, :show]
    # def index
    #     @projects = Project.all
    # end

    def show
        if !@project.public
            check_for_user_permission
        end
        @write_privilege = check_for_write_privilege
        
        if cookies[:last_project_visited].to_i != @project.id
            @project.views += 1
            @project.save
        end
        cookies[:last_project_visited] = @project.id

        @posts = @project.sort_my_posts_by_urgency
        session[:project_id] = @project.id
    end

    def new
        @project = Project.new
    end

    def create 
        @project = Project.new(project_params)
        if @project.save
            @project.users << User.find(session[:user_id]) #This breaks if we move it before the first @project.save
            @project.save
            cookies[:last_user_id] = session[:user_id]
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
        @user = User.find(params[:user_id])
        @project.add_user(@user)

        redirect_to project_invite_path
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
        params.require(:project).permit(:title, :description, :public)
    end

    def check_for_user_permission
        if logged_in?
            user = User.find(session[:user_id])
            if !@project.users.include?(user)
                if @project.public
                    flash[:error_message] = "You don't have permission to do that"
                    redirect_to project_path(@project)
                else
                    flash[:error_message] = "You don't have permission to view this project"
                    redirect_to user_path(user)
                end
            end
        else
            flash[:error_message] = "Please log in with valid credentials"
            redirect_to login_path
        end
    end

    def check_for_write_privilege
        if logged_in?
            user = User.find(session[:user_id])
            if @project.users.include?(user)
                return true
            end
        end
        return false
    end
end