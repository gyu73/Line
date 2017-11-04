class FriendsController < ApplicationController
  def index
    @friends = current_user.friends.includes(:friend_groups).includes(:groups)
    binding.pry
  end
end
