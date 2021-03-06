class GroupsController < ApplicationController
  def index
    @groups = current_user.groups.includes(:user_groups).includes(:users).includes(:messages).order('message_created_at DESC')
    @counts = count_not_read_messages(@groups)
  end

  def create
    friend = User.find(friend_params[:friend_id])
    new_group = Group.create(name: "No name", message_created_at: Time.new)
    usergroup_user = UserGroup.new(user_id: current_user.id, group_id: new_group.id)
    usergroup_friend = UserGroup.new(user_id: friend.id, group_id: new_group.id)
    if usergroup_user.save && usergroup_friend.save
      redirect_to group_url(new_group)
    end
  end

  def show
    if Group.last.id >= params[:id].to_i && current_user.groups.ids.include?(Group.find(params[:id]).id)
      @current_group = Group.find(params[:id])
      @messages = Message.where(group_id: params[:id]).includes(:user).includes(:already_reads)
      @users = @current_group.users
      @new_message = Message.new
      AlreadyRead.where(is_read: false, message_id: @messages.ids).where.not(user_id: current_user.id).update(is_read: true)
        respond_to do |format|
          format.html
          format.json { render json: update_new_messages_json }
        end
    else
      redirect_to groups_path
    end
  end

  private

  def friend_params
    params.permit(:friend_id)
  end

  def last_message_params
    params.permit(:LastMessageId, :id)
  end

  def count_not_read_messages(groups)
    counts = []
    groups.each do |group|
      messages = group.messages.includes(:already_reads).where.not(user_id: current_user.id)
      count = 0
      messages.each do |message|
        count += 1 unless message.already_reads[0].is_read
      end
      counts << count
    end
    return counts
  end

  def update_new_messages_json
    update_messages = Message.where(group_id: last_message_params[:id]).where("id > ?", last_message_params[:LastMessageId])
    update_messages_json = []
    update_messages.each do |up_mes|
      if up_mes.user_id == current_user.id
        update_messages_json << { message_id: up_mes.id, name: up_mes.user.name, created_at: up_mes.created_at.strftime('%H:%M:%S'), message: up_mes.message, is_read: up_mes.already_reads[0].is_read, user_info: "current_user" }
      else
        update_messages_json << { message_id: up_mes.id, name: up_mes.user.name, created_at: up_mes.created_at.strftime('%H:%M:%S'), message: up_mes.message, is_read: up_mes.already_reads[0].is_read, user_info: "not_current_user" }
      end
    end
    return update_messages_json
  end
end
