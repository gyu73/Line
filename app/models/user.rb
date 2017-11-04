class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_friends, class_name: 'Friend', foreign_key: :user_id
  has_many :friend_friends, class_name: 'Friend', foreign_key: :friend_id
  has_many :messages
  has_many :user_groups
  has_many :groups , through: :user_groups
  has_many :already_reads
end
