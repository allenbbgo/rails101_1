class Account::GroupsController < ApplicationController
    before_action :authenticate_user!

    def index
        @groups = current_user.zxcer_groups
    end


end
