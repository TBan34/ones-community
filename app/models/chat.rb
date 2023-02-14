class Chat < ApplicationRecord
  
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :room
  
  # ブロードキャスト
  # after_create_commit { ChatBroadcastJob.perform_later self }
  
end
