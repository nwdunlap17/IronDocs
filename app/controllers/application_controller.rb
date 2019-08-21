class ApplicationController < ActionController::Base
    helper_method :check_for_login, :logged_in?, :set_user

        def check_for_login
            if !!!logged_in?
                redirect_to login_path
            end
        end

        def logged_in?
            return !!session[:user_id]
        end

        def set_user
            @user = User.find(session[:user_id])
        end
end
