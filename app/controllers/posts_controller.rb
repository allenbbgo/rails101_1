class PostsController < ApplicationController
    before_action :authenticate_user!, :only => [:new, :create]
    
    # def index 
    #     # @groups =Group.all
    #     @groups =Group.includes(:user)
    #     # @groups =Group.joins(:user)

    # end

    def new 
        @group = Group.find(params[:group_id])
        @post = Post.new
    end

    def create
        @group = Group.find(params[:group_id])
        @post  = Post.new(post_params)
        @post.group = @group
        @post.user = current_user

        if @post.save
            redirect_to group_path(@group)
        else
            render :new
        end

    end

    def edit
        find_group_and_check_permission

    end

    def update
        find_group_and_check_permission

        if @post.update(post_params)

        redirect_to account_posts_path,notice: "update ok"
            else
                render :edit
            end
    end

    def destroy
        @post =  Post.find(params[:id])

        @post.destroy
        flash[:alert] = "Post delete ok"
        redirect_to account_posts_path
    end


    private 

    def post_params
        params.require(:post).permit(:content)
    end

    def find_group_and_check_permission
        @post =  Post.find(params[:id])   
        @group = Group.find(params[:group_id])
        if current_user != @group.user
            redirect_to root_path, alert: "權限不足，請登入帳號"
        end

    end


end
