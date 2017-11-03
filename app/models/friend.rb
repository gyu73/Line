class Friend < ApplicationRecord
  has_many :friend_groups
  has_many :groups , through: :friend_groups
  has_many :user_friends
  has_many :users, through: :user_friends
end
