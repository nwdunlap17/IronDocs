class AuthController < ApplicationController

    def  login
    end

    def verify
      @user = User.find_by(username: params[:login][:username])
      if @user && @user.authenticate(params[:login][:password])

        session[:user_id] = @user.id
        redirect_to user_path(@user)

      else
        flash[:error_message] = "Incorrect credentials!"
        render :login
      end

    end
end