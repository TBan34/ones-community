class RenameTimeColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :time, :datetime
  end
end
