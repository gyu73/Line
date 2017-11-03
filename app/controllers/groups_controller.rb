class GroupsController < ApplicationController
  def index
    @groups = current_user.groups.includes(:user_groups).includes(:users).includes(:messages).limit(1)
    binding.pry
  end

  def show
    @current_group = Group.find(params[:id])
    @messages = Message.where(group_id: params[:id]).includes(:user)
    @users = @current_group.users
    @new_message = Message.new
  end
end
