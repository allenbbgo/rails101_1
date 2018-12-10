class GroupsController < ApplicationController
before_action :authenticate_user! , only: [:new, :create]
before_action :find_group_and_check_permission, only: [:edit,:update,:destroy]

    def index 
        @groups =Group.all
    end
    

    def new
        @group =Group.new
    end

    def create 
        @group = Group.new(group_params)
        @group.user = current_user
        if @group.save

        redirect_to groups_path
        else
            render :new
        end
    end

    def show
        @group = Group.find(params[:id])
        @post = @group.posts.recentt.paginate(:page => params[:page], :per_page=>5)

        

    end



    def edit
        find_group_and_check_permission
    end

    def update
        find_group_and_check_permission

        if @group.update(group_params)

        redirect_to groups_path,notice: "update ok"
            else
                render :edit
            end
    end

    def destroy
        find_group_and_check_permission

        @group.destroy
        flash[:alert] = "Group delete ok"
        redirect_to groups_path
    end


    private

    def group_params
        params.require(:group).permit(:title,:description)
    end

    def find_group_and_check_permission
        @group = Group.find(params[:id])   

        if current_user != @group.user
            redirect_to root_path, alert: "權限不足，請登入帳號"
        end

    end
end
