class UsersController < ApplicationController
    before_action :grab_user, only: [:show]
    def index
        @users = User.all
    end

    def show
        @projects = @user.projects
        
    end

    def new
        @user = User.new
    end

    def create
        if params[:passhash] == params[:passhashconfirm]    
            @user = User.new(user_params)
            if @user.save
                redirect_to user_path(@user)
            else
                render :new
            end
        else
            @user = User.new(user_params)
            render :new
        end
    end

    private

    def grab_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :passhash)
    end

    def passwordHash
        if params[:password][:first] 
            params[:user][:passhash] = "#{params[:password][:first].reverse}"
            params[:user][:passhashconfirm] = "#{params[:password][:confirm].reverse}"
        else
            params[:user][:passhash] = "#{params[:password].reverse}"
        end
    end
end
