class WelcomeController < ApplicationController
    def index 
        flash[:notice] = "good"
        flash[:alert]="goodnight"
        flash[:warning]="fail"
    end
end
