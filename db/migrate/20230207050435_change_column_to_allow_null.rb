class ChangeColumnToAllowNull < ActiveRecord::Migration[6.1]
  def change
  def up
    change_column :users, :prefecture, :string, null: true
    change_column :users, :municipality, :string, null: true
    change_column :users, :display_name, :string, null: true
    change_column :users, :self_introduction, :text, null: true
  end
  
  def down
    change_column :users, :prefecture, :string, null: false
    change_column :users, :municipality, :string, null: false
    change_column :users, :display_name, :string, null: false
    change_column :users, :self_introduction, :text, null: false
  end
  end
end
