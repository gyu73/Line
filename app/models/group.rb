class Group < ApplicationRecord
  has_many: messages
  has_many: user_group
  has_many: users , through: :user_group
end
