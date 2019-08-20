class AuthController < ApplicationController

    def  login
    end

    def verify
      @user = User.find_by(username: params[:login][:username])
      byebug
      if @user && @user.authenticate(params[:login][:password])
        byebug
        redirect_to user_path(@user)

      else
        flash[:error_message] = "Incorrect credentials!"
        render :login
      end

    end
end