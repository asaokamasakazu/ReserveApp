class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :room_id
      t.integer :user_id
      t.integer :number_of_people
      t.string :start_day
      t.string :finish_day

      t.timestamps
    end
  end
end
