class Group < ApplicationRecord
  has_many :messages
  has_many :user_groups
  has_many :users , through: :user_groups
  has_many :friend_groups
  has_many :friends , through: :friend_groups
end
