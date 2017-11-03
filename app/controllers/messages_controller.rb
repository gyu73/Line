class MessagesController < ApplicationController
  def index
  end

  def create
    message = current_user.messages.new(message_params)
    if message.save
    end
  end

  private

  def message_params
    params.require(:message).permit(:message, :group_id)
  end
end
