class FriendsController < ApplicationController
  def index
    current_user_and_friends_ids = [current_user.id]
    users_friends = Friend.where(user_id: current_user.id)
    users_friends.each do |friend|
      current_user_and_friends_ids << friend.friend_id
    end
    @friends = User.where(id: current_user_and_friends_ids).where.not(id: current_user.id).includes(:user_groups).includes(:groups)
  end

  def search
    current_user_and_friends_ids = [current_user.id]
    users_friends = Friend.where(user_id: current_user.id)
    users_friends.each do |friend|
      current_user_and_friends_ids << friend.friend_id
    end
    @not_friends = User.where.not(id: current_user_and_friends_ids)
  end

  def create
    new_friend1 = Friend.new(user_id: current_user.id, friend_id: friends_params[:friend_id])
    new_friend2 = Friend.new(user_id: friends_params[:friend_id], friend_id: current_user.id )
    if new_friend1.save && new_friend2.save
      redirect_to friends_url
    end
  end

  private

  def friends_params
    params.require(:friend).permit(:friend_id)
  end
end
