class Message < ApplicationRecord

  def create_current_user_message_json
    { message_id: id, name: user.name, created_at: created_at.strftime('%Y年%m月%d日 %H:%M:%S'), message: message, user_info: "current_user" }
  end

  def create_not_current_user_message_json
    { message_id: id, name: user.name, created_at: created_at.strftime('%Y年%m月%d日 %H:%M:%S'), message: message, user_info: "not_current_user" }
  end

  belongs_to :user
  belongs_to :group

  validates :message, presence: true, length: {maximum: 225}
end
