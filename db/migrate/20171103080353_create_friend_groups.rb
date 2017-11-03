class CreateFriendGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_groups do |t|
      t.references :friend, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
