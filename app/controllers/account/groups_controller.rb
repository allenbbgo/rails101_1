class Account::GroupsController < ApplicationController
    before_action :authenticate_user!

    def index
        
        @group = current_user.zxcer_groups
        @g = current_user.zxcer_groups
        #  @group = Group.includes(:user)
    end


end
