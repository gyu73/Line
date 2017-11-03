class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_friends
  has_many :friends, through: :user_friends
  has_many :messages
  has_many :user_groups
  has_many :groups , through: :user_groups
end
