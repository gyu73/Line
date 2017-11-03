class AddMessageCreatedToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :message_created_at, :timestamp
  end
end
