class GroupsController < ApplicationController
  def index
  end

  def show
    @current_group = Group.find(params[:id])
    @messages = Message.where(group_id: params[:id]).includes(:user)
    @users = @current_group.users
    @new_message = Message.new
    binding.pry
  end
end
