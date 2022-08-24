class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :introduction
      t.integer :price
      t.text :address
      t.string :image_name

      t.timestamps
    end
  end
end
