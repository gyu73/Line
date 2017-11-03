class FriendsController < ApplicationController
  def index
    @friends = current_user.friends
    binding.pry
  end
end
