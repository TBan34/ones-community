class Room < ApplicationRecord
  
  has_many :user_rooms, dependent: :destroy
  has_many :chats
  has_many :users, through: :user_rooms
  belongs_to :post

end
