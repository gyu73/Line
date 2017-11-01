class Group < ApplicationRecord
  has_many :messages
  has_many :user_groups
  has_many :users , through: :user_group
end