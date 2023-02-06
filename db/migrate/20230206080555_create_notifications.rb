class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer "user_notification_id", null: false
      t.integer "post_id", null: false
      t.integer "chat_id", null: false
      t.integer "favorite_id", null: false
      t.integer "comment_id", null: false
      t.string "action", null: false
      t.boolean "checked", default: false, null: false
      t.timestamps
    end
  end
end
