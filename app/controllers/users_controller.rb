class UsersController < ApplicationController
    before_action :grab_user, only: [:show]
    before_action :check_for_login, except: [:new, :create, :show]
    # def index
    #     @users = User.all
    # end

    def show

        @user.update_post_alert_dates
        @posts = @user.search_my_posts_by_name_and_priority(params[:search])
        @projects = @user.search_my_projects_by_name(params[:search])
        cookies[:last_user_id] = @user.id
    end

    def new
        @user = User.new
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            if flash[:alert_message]
                flash[:alert_message].clear
              end
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            if User.find_by(username: params[:user][:username])
            flash[:alert_message] = "This username is taken"
            else
                flash[:alert_message] = "Passwords don't match"
            end
            render :new
        end
    end

    private

    def grab_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
