class GroupsController < ApplicationController
  def index
    @groups = current_user.groups.includes(:user_groups).includes(:users).includes(:messages).order('message_created_at DESC')
  end

  def create
    friend = Friend.find(friend_params[:friend_id])
    new_group = Group.create(name: "No name", message_created_at: Time.new)
    usergroup_user = UserGroup.new(user_id: current_user.id, group_id: new_group.id)
    usergroup_friend = UserGroup.new(user_id: friend.id, group_id: new_group.id)
    friendgroup = FriendGroup.new(friend_id: friend.id, group_id: new_group.id)
    if usergroup_user.save && usergroup_friend.save && friendgroup.save
      redirect_to friends_url
    end
  end

  def show
    @current_group = Group.find(params[:id])
    @messages = Message.where(group_id: params[:id]).includes(:user).includes(:already_reads)
    @users = @current_group.users
    @new_message = Message.new
    AlreadyRead.where(is_read: false, message_id: @messages.ids).where.not(user_id: current_user.id).update(is_read: true)
    binding.pry
  end

  private

  def friend_params
    params.permit(:friend_id)
  end
end
