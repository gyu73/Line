class CreateAlreadyReads < ActiveRecord::Migration[5.1]
  def change
    create_table :already_reads do |t|
      t.references :user, foreign_key: true
      t.references :message, foreign_key: true
      t.boolean :is_read, default: 0, index: false
      t.timestamps
    end
  end
end
