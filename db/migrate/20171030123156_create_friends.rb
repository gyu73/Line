class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|
      t.string :name
      t.string :email
      t.string :avatar

      t.timestamps
    end
  end
end
