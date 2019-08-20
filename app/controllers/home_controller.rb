class HomeController < ApplicationController

    def home 
        @search = nil
        @projects = []
        #@projects = Most popular projects
        @users = []
        render :home
    end

    def public_search
        @search = params[:search]
        if @search == nil

        else
          @projects = Project.search_by_title(@search)
          @users = User.search_public_by_username(@search)
        end
        render :home
    end
end
