class MessagesController < ApplicationController
  def index
  end

  def create
    message = current_user.messages.new(message_params)
    current_group = Group.find(message_params[:group_id])
    if message.save && current_group.update(message_created_at: Time.new)
    end
  end

  private

  def message_params
    params.require(:message).permit(:message, :group_id)
  end
end
