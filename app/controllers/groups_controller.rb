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
        current_user.Join!(@group)
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


    def join
        @group = Group.find(params[:id])

        if !current_user.is_member_of?(@group)
            current_user.Join!(@group)
            flash[:notice] = " 加入本討論板成功"
        else
            flash[:warning] = "你已經入本討論"
        end
        
        redirect_to group_path(@group)
    end

    def quit
        @group = Group.find(params[:id])

        if current_user.is_member_of?(@group)
            current_user.Quit!(@group)
            flash[:alert] = "成功退出"
            else
            flash[:warning] = "你已成功退出"
            end

            redirect_to group_path(@group)

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
