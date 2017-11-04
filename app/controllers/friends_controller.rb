class FriendsController < ApplicationController
  def index
    @friends = User.where(id: current_user.user_friends.ids).where.not(id: current_user.id).includes(:user_groups).includes(:groups)
  end
end
