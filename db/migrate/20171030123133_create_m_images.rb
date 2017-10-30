class CreateMImages < ActiveRecord::Migration[5.1]
  def change
    create_table :m_images do |t|
      t.string :Mimage

      t.timestamps
    end
  end
end
