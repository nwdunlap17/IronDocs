class ApplicationController < ActionController::Base
    helper_method :check_for_login

        def check_for_login
            if !!!session[:user_id]
                redirect_to login_path
            end
        end
end
