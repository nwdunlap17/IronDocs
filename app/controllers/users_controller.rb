class UsersController < ApplicationController
    before_action :grab_user, only: [:show]
    before_action :check_for_login, except: [:new, :create, :show]
    # def index
    #     @users = User.all
    # end

    def show
        @projects = @user.visible_projects(session[:user_id])
        cookies[:last_user_id] = @user.id
    end

    def new
        @user = User.new
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
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
