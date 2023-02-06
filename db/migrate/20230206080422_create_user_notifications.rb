class CreateUserNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :user_notifications do |t|
      t.integer "visitor_id", null: false
      t.integer "visited_id", null: false
      t.timestamps
    end
  end
end
