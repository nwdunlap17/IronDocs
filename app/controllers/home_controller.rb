class HomeController < ApplicationController

    def home 
        @search = nil
        @projects = Project.top_5_public_projects
        @users = []
        render :home
    end

    def public_search
        @search = params[:search]
        
        if @search == ""
            @projects = Project.top_5_public_projects
            @users = []
        else
          @projects = Project.search_by_title(@search)
          @users = User.search_public_by_username(@search)
        end
        render :home
    end
end
