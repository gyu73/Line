class MessagesController < ApplicationController
  def index
  end

  def create
    message = current_user.messages.new(message_params)
    current_group = Group.find(message_params[:group_id])
    if message.save && current_group.update(message_created_at: Time.new)
      AlreadyRead.create(user_id: current_user.id, message_id: message.id)
      respond_to do |format|
        format.html { redirect_to group_url(current_group)}
        if current_user.id == message.user.id
          format.json { render json: message.create_current_user_message_json}
        else
          format.json { render json: message.create_not_current_user_message_json}
        end
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:message, :group_id)
  end
end
