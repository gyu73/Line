class UsersController < ApplicationController
  def index
    users_friends = current_user.user_friends
    friends = User.where('name LIKE(?)', "#{friend_name_params[:keyword]}%").where.not("name = '#{current_user.name}'").where.not(id: users_friends.ids)
      respond_to do |format|
        format.html
        format.json{ render json: create_friend_json(friends) }
      end
  end

  private

  def friend_name_params
    params.require(:friend_name).permit(:keyword)
  end

  def create_friend_json(friends)
    if friends.present?
      friends_lists = []
      friends.each do |f|
        friends_lists << { user_id: f.id, name: f.name }
      end
      return friends_lists
    else
      return friends_lists
    end
  end
end
