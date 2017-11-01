class GroupsController < ApplicationController
  def index
  end

  def show
    @messages = Message.where(group_id: params[:id]).includes(:user)
    @new_message = Message.new
  end
end
