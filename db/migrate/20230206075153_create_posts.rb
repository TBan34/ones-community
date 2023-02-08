class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer "user_id", null: false
      t.integer "room_id", null: true
      t.string "title", null: false
      t.text "body", null: false
      t.string "time", null: false
      t.string "place", null: false
      t.string "belonging", null: false
      t.timestamps
    end
  end
end
