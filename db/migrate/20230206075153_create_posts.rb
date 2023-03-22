class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer "user_id", null: false
      t.string "title", null: false
      t.text "body", null: false
      t.datetime "since_when", null: false
      t.string "at_where", null: false
      t.string "for_playing", null: false
      t.integer "status", null: false, default: 0
      t.timestamps
    end
  end
end
