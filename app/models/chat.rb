class Chat < ApplicationRecord
  
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :room
  
  def create_notification_chat!(current_user)
    temp_users = room.users.where.not(id: current_user.id)
    temp_users.each do |temp_user|
      save_notification_chat!(current_user, temp_user.id)
    end
  end
  
  def save_notification_chat!(current_user, visited_id)
    notification = current_user.active_notifications.new(chat_id: id, visited_id: visited_id, action: "chat")
    notification.save if notification.valid?
  end
  
  # ブロードキャスト
  # after_create_commit { ChatBroadcastJob.perform_later self }
  
end
