class AuthController < ApplicationController

    def  login
    end
    
    def  public_search
      render :login
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

    def destroy
        session.clear
        redirect_to :login
    end

    # def current_user
    #     if session[:user_id]
    #         @current_user ||= User.find_by(id: session[:user_id])
    #     end
    # end

    # def logged_in?
    #     !current_user.nil?
    # end
end